#encoding=utf-8

module Commontator
  class CommentsController < Commontator::ApplicationController
    before_filter :set_thread, :only => [:new, :create]
    before_filter :set_modal, only: [:new, :create, :edit, :update, :delete]
    before_filter :set_comment_and_thread, :except => [:new, :create]

    # GET /threads/1/comments/new
    def new
      @comment = Comment.new
      @comment.thread = @thread
      @comment.creator = @user
      security_transgression_unless @comment.can_be_created_by?(@user)

      @per_page = params[:per_page] || @thread.config.comments_per_page

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js
      end
    end

    # POST /threads/1/comments
    def create
      @comment = Comment.new
      @comment.thread = @thread
      @comment.creator = @user
      @comment.body = params[:comment].nil? ? nil : params[:comment][:body]
      security_transgression_unless @comment.can_be_created_by?(@user)

      respond_to do |format|
        if  !params[:cancel].nil?
          format.html { redirect_to @thread }
          format.js { render :cancel }
        elsif @comment.save
          status = Status.find(@thread.commontable_id)
          group = status.character.group
          recipient = status.character.user_id
          datestr = status.verified_at.strftime("%-m월 %-d일")

          Notification.create!(
            user: current_user,
            recipient: recipient,
            description: "[#{group.name}] 그룹에서 #{User.find(recipient).name}님의 #{datestr} 실천에 댓글을 달았습니다.",
            link: main_app.group_path(group),
            group: group,
            status: status)

          sub = @thread.config.thread_subscription.to_sym
          @thread.subscribe(@user) if sub == :a || sub == :b
          Subscription.comment_created(@comment)

          @per_page = params[:per_page] || @thread.config.comments_per_page

          format.html { redirect_to @thread }
          format.js
        else
          format.html { redirect_to @thread }
          format.js { render :new }
        end
      end
    end

    # GET /comments/1/edit
    def edit
      security_transgression_unless @comment.can_be_edited_by?(@user)

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js
      end
    end

    # PUT /comments/1
    def update
      security_transgression_unless @comment.can_be_edited_by?(@user)
      @comment.body = params[:comment].nil? ? nil : params[:comment][:body]
      @comment.editor = @user

      respond_to do |format|
        if !params[:cancel].nil?
          format.html { redirect_to @thread }
          format.js { render :cancel }
        elsif @comment.save
          format.html { redirect_to @thread }
          format.js
        else
          format.html { redirect_to @thread }
          format.js { render :edit }
        end
      end
    end

    # PUT /comments/1/delete
    def delete
      security_transgression_unless @comment.can_be_deleted_by?(@user)

      @comment.errors.add(:base, t('commontator.comment.errors.already_deleted')) \
        unless @comment.delete_by(@user)

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js { render :delete }
      end
    end

    # PUT /comments/1/undelete
    def undelete
      security_transgression_unless @comment.can_be_deleted_by?(@user)

      @comment.errors.add(:base, t('commontator.comment.errors.not_deleted')) \
        unless @comment.undelete_by(@user)

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js { render :delete }
      end
    end

    # PUT /comments/1/upvote
    def upvote
      security_transgression_unless @comment.can_be_voted_on_by?(@user)

      @comment.upvote_from @user

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js { render :vote }
      end
    end

    # PUT /comments/1/downvote
    def downvote
      security_transgression_unless @comment.can_be_voted_on_by?(@user) &&\
        @comment.thread.config.comment_voting.to_sym == :ld

      @comment.downvote_from @user

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js { render :vote }
      end
    end

    # PUT /comments/1/unvote
    def unvote
      security_transgression_unless @comment.can_be_voted_on_by?(@user)

      @comment.unvote :voter => @user

      respond_to do |format|
        format.html { redirect_to @thread }
        format.js { render :vote }
      end
    end

    protected

    def set_comment_and_thread
      @comment = Comment.find(params[:id])
      @thread = @comment.thread
      commontator_set_new_comment(@thread, @user)
    end

    def set_modal
      @modal_class = params[:modal]
    end
  end
end
