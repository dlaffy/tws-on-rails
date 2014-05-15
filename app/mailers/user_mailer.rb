class UserMailer < ActionMailer::Base
  default from: "sayhi@teawithstrangers.com"

  def user_registration(user, password)
    @user = user; @password=password;
    mail(to: @user.email, subject: 'High fives from Tea With Strangers!').deliver!
  end

  def tea_time_registration(attendance)
    @attendance = attendance
    tt = attendance.tea_time
    end

    mail.attachments['event.ics'] = {mime_type: "text/calendar", content: tt.ito_cal.to_ical}
    mail(to: attendance.user.email, subject: "See you at tea time!")
  end

  def tea_time_cancellation(tea_time)
    @tea_time = @tea_time
    tea_time.attendances.each do |att|
      @user = att.user 
      mail(to: @user.email, subject: "Sad days — tea time canceled").deliver!
    end
  end

  def tea_time_flake(attendance)
    @user = attendance.user
    @tea_time = attendance.tea_time
    mail(to: @user.email, subject: "Let's find another tea time that works for you!").deliver!
  end
end
