class LoansController < ApplicationController
  def new
    @loan = Loan.new
  end

  def create
    @loan = Loan.new
    @loan.start_date = params[:loan][:start_date]
    @loan.due_date = params[:loan][:due_date]
    @loan.borrower = User.find_by(name: params[:loan][:borrower])

    @tool = Tool.find_by(name: params[:loan][:tool])
    @loan.tool = @tool

    if @loan.save
      flash[:notice] = "Tool successfully lended!"
      redirect_to tool_url(@tool)
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end

end
