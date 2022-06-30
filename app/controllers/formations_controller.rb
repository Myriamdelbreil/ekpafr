class FormationsController < ApplicationController
  def index
    if params[:query].present?
      # si je fais une recherche depuis la page d'accueil
      @pagy, @formations = pagy(Formation.joins(:theme).where('sujet ILIKE ?', params[:query]), items: 9)
      @formations_count = Formation.joins(:theme).where('sujet ILIKE ?', params[:query]).count
      @search = params[:query]
    elsif !params[:sujet].nil? # ça veut dire que j'ai lancé une recherche
      if !params[:prix].to_i.zero? && params[:lieu].to_i.zero? && !params[:sujet][:id].to_i.zero?
        # si j'ai un paramètre de sujet & de prix mais pas de lieu
        search_with_prix_and_sujet
      elsif params[:prix].to_i.zero? && !params[:lieu].to_i.zero? && !params[:sujet][:id].to_i.zero?
        # si j'ai un paramètre de sujet & de lieu mais pas de prix
        search_with_sujet_and_lieu
      elsif !params[:prix].to_i.zero? && !params[:lieu].to_i.zero? && !params[:sujet][:id].to_i.zero?
        # si j'ai les 3 paramètres
        search_with_3_parameters
      elsif params[:prix].to_i.zero? && params[:lieu].to_i.zero? && !params[:sujet][:id].to_i.zero?
        # si j'ai une recherche avec uniquement le paramètre du thème
        search_with_only_sujet
      elsif params[:sujet][:id].to_i.zero? && !params[:prix].to_i.zero? && !params[:lieu].to_i.zero?
        # si j'ai une recherche avec uniquement un prix & un lieu
        search_with_prix_and_lieu
      elsif params[:sujet][:id].to_i.zero? && !params[:prix].to_i.zero? && params[:lieu].to_i.zero?
        # si j'ai une recherche qu'avec un prix
        search_with_only_prix
      elsif params[:sujet][:id].to_i.zero? && params[:prix].to_i.zero? && !params[:lieu].to_i.zero?
        # si j'ai une recherche qu'avec un lieu
        search_with_only_lieu
      end
    elsif params[:sujet].nil?
      @themes = Theme.all
      @pagy, @formations = pagy(Formation.includes(:theme).where(nil).all, items: 9)
    end
  end

  def show
    @formation = Formation.find(params[:id])
  end

  def search_with_only_sujet
    @param = (params[:sujet][:id]).to_i
    @pagy, @formations = pagy(Theme.find(@param).formations, items: 9)
    @formations_count = Theme.find(@param).formations.count
    @search = Theme.find(@param).sujet
  end

  def search_with_only_prix
    @pagy, @formations = pagy(Formation.where('prix <= ?', params[:prix]), items: 9)
    @formations_count = Formation.where('prix <= ?', params[:prix]).count
  end

  def search_with_only_lieu
    if params[:lieu] == '1'
      @pagy, @formations = pagy(Formation.where('lieu ILIKE ?', 'remote'), items: 9)
      @formations_count = Formation.where('lieu ILIKE ?', 'remote').count
    elsif params[:lieu] == '2'
      @pagy, @formations = pagy(Formation.where.not('lieu ILIKE ?', 'remote'), items: 9)
      @formations_count = Formation.where.not('lieu ILIKE ?', 'remote').count
    elsif params[:lieu] == '3'
      @pagy, @formations = pagy(Formation.includes(:theme).all, items: 9)
      @formations_count = Formation.includes(:theme).all
    end
  end

  def search_with_prix_and_sujet
    @param = (params[:sujet][:id]).to_i
    @pagy, @formations = pagy(Theme.find(@param).formations.where('prix <= ?', params[:prix]), items: 9)
    @formations_count = Theme.find(@param).formations.where('prix <= ?', params[:prix]).count
  end

  def search_with_sujet_and_lieu
    @param = (params[:sujet][:id]).to_i
    if params[:lieu] == '1'
      @pagy, @formations = pagy(Theme.find(@param).formations.where('lieu ILIKE ?', "Remote"), items: 9)
      @formations_count = Theme.find(@param).formations.where('lieu ILIKE ?', "Remote").count
    elsif params[:lieu] == '2'
      @pagy, @formations = pagy(Theme.find(@param).formations.where.not('lieu ILIKE ?', "Remote"), items: 9)
      @formations_count = Theme.find(@param).formations.where.not('lieu ILIKE ?', "Remote").count
    elsif params[:lieu] == '3'
      search_with_only_sujet
    end
  end

  def search_with_prix_and_lieu
    if params[:lieu] == '1'
      @pagy, @formations = pagy(Formation.where('prix <= ?', params[:prix]).where('lieu ILIKE ?', 'Remote'), items: 9)
      @formations_count = Formation.where('prix <= ?', params[:prix]).where('lieu ILIKE ?', 'Remote').count
    elsif params[:lieu] == '2'
      @pagy, @formations = pagy(Formation.where('prix <= ?', params[:prix]).where.not('lieu ILIKE ?', 'Remote'), items: 9)
      @formations_count = Formation.where('prix <= ?', params[:prix]).where.not('lieu ILIKE ?', 'Remote')
    elsif params[:lieu] == '3'
      search_with_only_prix
    end
  end

  def search_with_3_parameters
    @param = (params[:sujet][:id]).to_i
    if params[:lieu] == '1'
      @pagy, @formations = pagy(Theme.find(@param).formations.where('lieu ILIKE ?', "Remote").where('prix <= ?', params[:prix]), items: 9)
      @formations_count = Theme.find(@param).formations.where('lieu ILIKE ?', "Remote").where('prix <= ?', params[:prix]).count
    elsif params[:lieu] == '2'
      @pagy, @formations = pagy(Theme.find(@param).formations.where.not('lieu ILIKE ?', "Remote").where('prix <= ?', params[:prix]), items: 9)
      @formations_count = Theme.find(@param).formations.where.not('lieu ILIKE ?', "Remote").where('prix <= ?', params[:prix])
    elsif params[:lieu] == '3'
      search_with_prix_and_sujet
    end
  end

  private

  def theme_params
    params.require(:theme).permit(:id, :sujet)
  end
end
