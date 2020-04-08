class Api::GamesController < ApplicationController
  def create
    render json: { board: board }
  end

  def save
    params.require([:board, :submitted_words])
    evaluator = ::BoggleEvaluatorService.new(
      params[:board],
      params[:submitted_words]
    )

    render json: { valid_words: evaluator.valid_words, score: evaluator.score }
  end

  def board
    @board ||= ::BoggleService.new.board
  end
end
