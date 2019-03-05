class RanksController < ApplicationController
  def edit
    @ranks = get_ranks
    authorize_ranks
  end

  def update
    all_ranks = get_ranks

    @ranks = ranks_params
      .map { |ps| all_ranks.find(ps[:id]) }
      .each_with_index(&:'value=')

    authorize_ranks
    rankable_model.transaction do
      raise ActiveRecord::Rollback unless @ranks.map(&:save).all?
    end
    respond_with @ranks, action: 'edit', location: ->{ url_for(controller: rankable_controller, action: 'index') }
  end

private
  def ranks_params
    params.require(:ranks).map do |rank_params|
      rank_params.permit(:id)
    end
  end

  def rankable_model
    @_rankable_model ||= params.fetch(:model)
  end
  helper_method :rankable_model

  def rankable_controller
    rankable_model.name.pluralize.underscore
  end

  def authorize_ranks
    authorize @ranks.first || Rank.new(rankable: rankable_model.new)
  end

  def get_ranks
    Rank.where(rankable_type: rankable_model.name)
  end
end
