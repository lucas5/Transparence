module General
  class CongresspeopleController < ApplicationController

    def index
      @congresspeople = Congressperson.list_congresspeople(params[:year], params[:estado])
    end

    def ranking
      @congresspeople = Congressperson.rank(params[:year], params[:estado])
    end

    def show
      year = params[:year].present? ? params[:year] : Time.current.year

      @congressperson = Congressperson.find(params[:id])
      @spendings = @congressperson.spendings.filter_by_year(year).order("net_value DESC")
      @formated_spent = @spendings.select(:net_value, :txt_provider).limit(5)
    end

  end
end
