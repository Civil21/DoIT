class QuestionsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :set_question, only:[:show,:edit,:update,:destroy]

	def index
		@questions=Question.all
	end

	def show
		@answers=Answer.where(question_id: @question.id)
	end

	def new
		@question= Question.new
	end

	def create
		params[:question][:user_id]=current_user.id
		@question=Question.create(question_params)
		if @question.save
			@category=Category.find(@question.category.id)
			@category.update(count: @category.count+1)
			redirect_to question_path(@question.id)
		else

		end
	end

	def edit
		
	end

	def update
		@question.update(question_params)
		redirect_to question_path(@question.id)
	end

	def destroy
		@category=Category.find(@question.category.id)
		@category.update(count: @category.count-1)
		@question.destroy
		redirect_to root_path
	end

	private

	def question_params
		params.require(:question).permit(:user_id,:category_id,:name,:text,:answers)
	end

	def set_question
		@question=Question.find(params[:id])
	end
end
