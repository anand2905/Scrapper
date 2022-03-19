class EventsController < ApplicationController

  def index
    # binding.pry
    if params[:search]
      @parameter = params[:search].downcase
      @events = Event.all.where("lower(title) LIKE :search", search: "%#{@parameter}%").paginate(page: params[:page], per_page: 21)
    else
      @events = Event.paginate(page: params[:page], per_page: 21)
    end
  end

  def new
    @event = Event.new
  end

  def create
    @events = Event.new(events_params)
    if @events.save
      redirect_to events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def scrape_event
    if params[:url].include?('visitberlin')
      response = VisitBerlinService.process(params[:url])
    else
      response = GorkiService.process(params[:url])
    end
    redirect_to root_path
    if response[:status] == :completed && response[:error].nil?
      flash.now[:notice] = "Successfully scraped url"
    else
      flash.now[:alert] = response[:error]
    end
  rescue StandardError => e
    flash.now[:alert] = "Error: #{e}"
  end

  private
    def events_params
      params.require(:event).permit(:title, :date, :place, :description)
    end
end
