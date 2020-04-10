class Api::GamesController < ApplicationController
  def create
    render json: { board: board, valid_words: solver.find_all_words }
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

  def solver
    @solver ||= BoggleSolver.new(board)
  end
end
