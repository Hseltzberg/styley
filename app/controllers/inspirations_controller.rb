require "ai-chat"

class InspirationsController < ApplicationController
  def show
    @list_of_feelings = Feeling.where({}).order(name: :asc)
    @list_of_occasions = Occasion.where({}).order(name: :asc)
    @inspirations = []
  end

  def create
    @list_of_feelings = Feeling.where({}).order(name: :asc)
    @list_of_occasions = Occasion.where({}).order(name: :asc)
    @feeling = Feeling.find_by(id: params[:feeling_id])
    @occasion = Occasion.find_by(id: params[:occasion_id])
    @season = params[:season]
    @inspirations = fetch_inspirations
    render :show
  end

  private

  def fetch_inspirations
    return [] unless ENV["AICHAT_PROXY_KEY"].present? || ENV["OPENAI_API_KEY"].present?

    context = []
    context << "They want to feel: #{@feeling.name}" if @feeling
    context << "Occasion: #{@occasion.name}" if @occasion
    context << "Season: #{@season.capitalize}" if @season.present?
    context << "Their style influences: #{current_user.style_description}" if current_user.style_description.present?

    chat = AI::Chat.new
    chat.system(system_prompt)
    chat.user(user_prompt(context))

    result = chat.generate!
    content = result[:content]
    return [] unless content

    JSON.parse(content)["inspirations"] || []
  rescue => e
    Rails.logger.error("Inspiration fetch failed: #{e.class}: #{e.message}")
    Rails.logger.error(e.backtrace.first(8).join("\n"))
    []
  end

  def system_prompt
    <<~PROMPT.strip
      You are a senior fashion editor at a classic, trend-resistant publication — the Vogue Paris archive, The Row, or Acne Studios.
      You suggest outfit directions grounded in real editorial history, not social media moments or micro-trends.
      You always cite a specific, real editorial reference: a named runway season, a real photographer's editorial shoot, or a specific brand lookbook.
      You never recommend micro-trends, fast fashion aesthetics, or anything that will feel dated in two years.
      Respond only with valid JSON.
    PROMPT
  end

  def user_prompt(context)
    <<~PROMPT.strip
      Generate 3 outfit inspiration concepts for this person.

      #{context.join("\n")}

      Each concept must:
      - Be grounded in a specific REAL editorial reference (name an actual runway season, a real photographer, or a real lookbook — never invented)
      - Be timeless — zero micro-trends, no algorithmically popular silhouettes, nothing fast fashion
      - Suggest specific garments with fabric or texture detail

      Return this exact JSON structure:
      {
        "inspirations": [
          {
            "title": "short evocative concept name (3-5 words)",
            "editorial_reference": "specific real reference, e.g. Phoebe Philo-era Céline S/S 2014",
            "description": "2-3 sentences: specific garments, fabrics, how they come together",
            "why_timeless": "one sentence on why this look has longevity beyond the moment",
            "color_palette": ["#hex1", "#hex2", "#hex3"],
            "key_pieces": ["piece 1", "piece 2", "piece 3"]
          }
        ]
      }
    PROMPT
  end
end
