class UserSessionsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  before_filter :require_admin    ,:only =>   [:index,:show]


  # GET /user_sessions/new
  # GET /user_sessions/new.xml
  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_session }
    end
  end





  # POST /user_sessions
  # POST /user_sessions.xml
  def create
    @user_session = UserSession.new(params[:user_session])
    @user = User.find_all_by_login(params[:user_session][:email])

    respond_to do |format|
      if @user_session.save
        flash[:notice] = "Welcome " + @user + "!"
        format.html { redirect_to(:appointments, :notice => 'Welcome!') }  #redirection von appointment hier
        format.xml  { render :xml => @user_session, :status => :created, :location => @user_session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.xml
  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.html { redirect_to(:login, :notice => 'Goodbye!') }
      format.xml  { head :ok }
    end
  end

  def forgot_password
    if current_user
      redirect_to user_path(current_user.id)
    else
      @user_session = UserSession.new()
    end
  end

  def forgot_password_lookup_email
    if current_user
      redirect_to user_path(current_user.id)
    else
      user = User.find_by_email(params[:user_session][:email])
      if user
        user.send_forgot_password!
        flash[:notice] = "A link to reset your password has been mailed to your " + @user.email + " email address."
      else
        flash[:notice] = "Email #{params[:user_session][:email]} wasn't found.  Perhaps you used a different one?"
        render :action => :forgot_password
      end
    end
  end

   def set_layout
   session["layout"] = (params[:mobile] == "1" ? "mobile" : "normal")
   redirect_to :action => "index"
  end
end