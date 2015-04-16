# encoding: UTF-8

class WeeklyRetrospectsController < ApplicationController
  before_action :set_weekly_retrospect, only: [:show, :edit, :update, :destroy]
  before_action :set_weekly_retrospect_hash, only: [:show, :new, :edit]
  before_action :set_weekly_retrospect_info, only: [:show, :edit]

  def index
    @weekly_retrospects = WeeklyRetrospect.all
  end

  def new
    @weekly_retrospect = WeeklyRetrospect.new
    @statuses = Status.during(view_context.last_weekly_goal.weeknum.all_week, current_character)
  end

  def monthly
    month_start = Time.zone.local(params[:year], params[:month]).to_date
    # Need redirection actually
    month_start = Date.today.beginning_of_month if month_start > Date.today

    @first_monday_of_month = month_start + ((8 - month_start.wday)%7).days

    @weeks = []
    week = @first_monday_of_month
    while @first_monday_of_month == view_context.season_start(week) do
      @weeks << week
      week += 7.days
    end

    @prev = @first_monday_of_month.prev_month
    @next = @first_monday_of_month.next_month
  end

  def create
    @weekly_retrospect = WeeklyRetrospect.new(
      user: current_user,
      weekly_goal: view_context.last_weekly_goal,
      questions: params[:questions],
      answers: params[:answers])

    if @weekly_retrospect.save
      @weekly_goal = WeeklyGoal.new(
        user: current_user,
        description: @weekly_retrospect.answers[:next_weekly_goal],
        weeknum: @weekly_retrospect.weekly_goal.weeknum.next_week)

      if @weekly_goal.save
        @daily_goal = DailyGoal.new(
          user: current_user,
          description: @weekly_retrospect.answers[:next_monday_goal],
          goal_date: @weekly_retrospect.weekly_goal.weeknum.next_week)
        if @daily_goal.save
          redirect_to @weekly_retrospect,
              notice: "#{view_context.advanced_weekstring view_context.last_weekly_goal.weeknum} 주간 회고가 저장되었습니다. #{view_context.link_to('홈 화면', root_path)}으로 돌아가시거나 #{view_context.link_to('회고를 수정', edit_weekly_retrospect_path(@weekly_retrospect))}하실 수 있습니다.}",
              flash: { html_safe: true }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @weekly_retrospect.update(weekly_retrospect_params)
        format.html { redirect_to @weekly_retrospect, notice: 'Weekly retrospect was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_retrospect }
      else
        format.html { render :edit }
        format.json { render json: @weekly_retrospect.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @weekly_retrospect.destroy
    respond_to do |format|
      format.html { redirect_to weekly_retrospects_url, notice: 'Weekly retrospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_weekly_retrospect
      @weekly_retrospect = WeeklyRetrospect.find(params[:id])
    end

    def weekly_retrospect_params
      params.require(:weekly_retrospect).permit(:user_id, :weekly_goal_id)
    end

    def set_weekly_retrospect_hash
      @this_week_description = "지난 일주일간 #{current_user.name}님이 실천한 것에 대해 전체적인 느낌, 좋았던 점, 아쉬웠던 점을 적어주세요. 이번 주 목표를 얼마나 달성했다고 생각하시나요?"
      @hashes_this_week =
      [ { name: 'overall_feeling', class: 'overall-feeling', question: '전체적 느낌:' },
        { name: 'goods', class: 'goods', question: '좋았던 점:' },
        { name: 'bads', class: 'bads', question: '아쉬었던 점:' },
        { name: 'accomplish', class: 'accomplish', question: '목표 달성 정도:' } ]

      @next_week_description = "이제 다음 주(#{view_context.weekstring view_context.last_weekly_goal.weeknum.next_week})에 대해 생각해 봅시다."
      @hashes_next_week =
      [ { name: 'next_weekly_goal', class: 'next-weekly-goal', question: '다음 주의 목표는 무엇인가요? (이번 주에 느낀 것을 토대로 목표/계획을 변경해도 됩니다)' },
        { name: 'next_monday_goal', class: 'next-monday-goal', question: "다음 주 월요일(#{view_context.datestring view_context.last_weekly_goal.weeknum.next_week})에는 무엇을 할지도 적어봅시다." },
        { name: 'next_monday_premortem', class: 'next-monday-premortem', question: '다음 주 월요일 밤이 되었다고 상상해 봅시다. 만약 목표를 성공하지 못했다면 그 이유는 무엇이었을까요?' },
        { name: 'how_to_success', class: 'how-to-success', question: '그러면, 목표를 성공하기 위해 어떻게 해보시겠어요?' } ]

      @our_question_description = "Havit 서비스에 대한 피드백을 적어주세요. 적극 반영하겠습니다!"
      @our_question = { name: 'havit_feedback', class: 'havit-feedback', question: '피드백: ' }
    end

    def set_weekly_retrospect_info
      @weekly_goal = @weekly_retrospect.weekly_goal
      @statuses = Status.during(@weekly_goal.weeknum.all_week, current_character)
    end
end
