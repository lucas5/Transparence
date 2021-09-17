module General
  class CongresspeopleController < ApplicationController

    def index
      @congresspeople = Congressperson.order(:name)
    end

    def ranking
      @congresspeople = Congressperson.rank
    end

    def show
      @congressperson = Congressperson.find(params[:id])
      @spendings = @congressperson.spendings.order("net_value DESC")
      @formated_spent = @spendings.select(:net_value, :txt_provider).limit(5)
    end

  end
end
