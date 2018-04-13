class LoansController < ApplicationController
  def new
    @loan = Loan.new
    @tool = Tool.find(params[:tool_id])
  end

  def show
    redirect_to new_tool_loan_url
  end

  def create
    @loan = Loan.new
    @loan.start_date = params[:loan][:start_date]
    @loan.due_date = params[:loan][:due_date]
    @loan.borrower = User.find_by(name: params[:loan][:borrower])

    @tool = Tool.find(params[:tool_id])
    @loan.tool = @tool
    @loan.active = true

    if @loan.save
      @tool.lend_out

      flash[:notice] = "Tool successfully lended!"
      redirect_to tool_url(@tool)
    else
      render :new
    end
  end

end
