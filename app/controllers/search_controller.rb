class SearchController < ApplicationController
  before_action :set_param
  before_action :authenticate_user!

  def index
    @groups = Group.search(
      @query,
      page: @page,
      order: { created_at: :desc },
      per_page: 20,
      fields: [
        { name: :word_middle },
        :description
        ],
      operator: 'or')
  end

  private

  def set_param
    @query = params[:query]
    @page = params[:page]
  end
end
