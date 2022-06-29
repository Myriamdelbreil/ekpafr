class FormationsController < ApplicationController
  def index
    @themes = Theme.all
    @pagy, @formations = pagy(Formation.includes(:theme).all, items: 9)
    @pagy, @formations = pagy(Formation.includes(:theme).where(nil).all, items: 9) # creates an anonymous scope
    if params[:query].present?
      @pagy, @formations = pagy(Formation.joins(:theme).where('sujet ILIKE ?', params[:query]), items: 9)
      @formations_count = Formation.joins(:theme).where('sujet ILIKE ?', params[:query]).count
      @search = params[:query]
    elsif params[:sujet].nil? && (params[:prix].nil? || params[:prix].to_i.zero?) && params[:lieu].nil?
      @themes = Theme.all
      @pagy, @formations = pagy(Formation.includes(:theme).all, items: 9)
    elsif !params[:sujet].nil? && !params[:sujet][:id].to_i.zero?
      @param = (params[:sujet][:id]).to_i
      @pagy, @formations = pagy(Theme.find(@param).formations, items: 9)
      @formations_count = Theme.find(@param).formations.count
      @search = Theme.find(@param).sujet
    elsif (params[:sujet].nil? || params[:sujet][:id]=="") && (!params[:prix].nil? || !params[:prix].to_i.zero?)
      @pagy, @formatons = pagy(Formation.where('prix <= ?', params[:prix]), items: 9)
    end

    # if params[:query].present?
    #   @pagy, @formations = pagy(Formation.joins(:theme).where('sujet ILIKE ?', params[:query]), items: 9)
    #   @formations_count = Formation.joins(:theme).where('sujet ILIKE ?', params[:query]).count
    #   @search = params[:query]
    # elsif params[:sujet].nil?
    #   @pagy, @formations = pagy(Formation.includes(:theme).where(nil).all, items: 9)
    # elsif (params[:lieu].present? && params[:lieu]) && params[:prix].present?
    #   @pagy, @formations = pagy(Formation.where('lieu ILIKE ?', 'Remote').where('prix <= ?', params[:prix]), items: 9)
    #   @formations_count = Formation.where('lieu ILIKE ?', 'Remote').where('prix <= ?', params[:prix]).count
    # elsif params[:prix].present?
    #   @pagy, @formations = pagy(Formation.where('prix <= ?', params[:prix]), items: 9)
    #   @formations_count = Formation.where('prix <= ?', params[:prix]).count
    # elsif params[:lieu].present? && params[:lieu]
    #   @pagy, @formations = pagy(Formation.where('lieu ILIKE ?', 'Remote'), items: 9)
    #   @formations_count = Formation.where('lieu ILIKE ?', 'Remote').count
    # elsif (!params[:sujet].nil? || params[:sujet][:id] != "" || !params[:sujet][:id].to_i.zero?) && params[:prix].present?
    #   @param = (params[:sujet][:id]).to_i
    #   @pagy, @formations = pagy(Theme.find(@param).formations.where('prix <= ?', params[:prix]), items: 9)
    #   @formations_count = Theme.find(@param).formations.where('prix <= ?', params[:prix]).count
    # elsif (!params[:sujet].nil? || params[:sujet][:id] != "") && (params[:lieu].present? && params[:lieu])
    #   @param = (params[:sujet][:id]).to_i
    #   @pagy, @formations = pagy(Theme.find(@param).formations.where('lieu ILIKE ?', 'Remote'), items: 9)
    #   @formations_count = Theme.find(@param).formations.where('lieu ILIKE ?', 'Remote').count
    # elsif !params[:sujet].nil? || params[:sujet][:id] != ""
    #   @param = (params[:sujet][:id]).to_i
    #   @pagy, @formations = pagy(Theme.find(@param).formations, items: 9)
    #   @formations_count = Theme.find(@param).formations.count
    #   @search = Theme.find(@param).sujet

    # end
  end

  def show
    @formation = Formation.find(params[:id])
  end

  def search
  end

  private

  def theme_params
    params.require(:theme).permit(:id, :sujet)
  end
end
