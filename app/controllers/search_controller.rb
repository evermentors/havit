class SearchController < ApplicationController
  before_action :set_param
  before_action :authenticate_user!

  def index
    if @query.blank?
      groups = Group.all.reject { |g| g==universe }
      @index = true
    else
      groups = Group.search(
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

    @groups_joined = []
    @groups_not_joined = []
    @groups_not_joined_count = 0

    groups.each do |g|
      if view_context.joined_group?(g)
        @groups_joined << g
      else
        @groups_not_joined << g
        @groups_not_joined_count += 1
      end
    end

    @groups_count = groups.count
  end

  private

  def set_param
    @query = params[:query]
    @page = params[:page]
  end
end
