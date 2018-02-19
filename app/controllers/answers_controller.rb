class AnswersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_answer, only:[:update,:destroy]

	def create
		params[:answer][:user_id]=current_user.id
		params[:answer][:question_id]=params[:question_id]
		@answer=Answer.create(answer_params)
		if @answer.save
			@question=Question.find(@answer.question.id)
			@question.update(count: @question.count+1)
			redirect_to question_path(@answer.question.id)
		else

		end
	end

	def update
		@answer.update(answer_params)
		redirect_to question_path(@answer.question.id)
	end

	def destroy
		@question=Question.find(@answer.question.id)
		@question.update(count: @question.count-1)
		@answer.destroy
		redirect_to question_path(params[:question_id])
	end

	private

	def answer_params
		params.require(:answer).permit(:user_id,:question_id,:text,:scores)
	end

	def set_answer
		@answer=Answer.find(params[:id])
	end
end
