module UserHelper
  def forward_time_days(n)
      DateTime.parse((Time.now + n * 86400).strftime("%Y-%m-%d %H:%M:%S"))
  end
end
