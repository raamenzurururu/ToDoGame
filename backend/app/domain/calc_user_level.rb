class CalcUserLevel
  def self.calc_user_level(user, total_exp)
    levelSetting = LevelSetting.find_by(level: user.level + 1)
    if levelSetting.present? && levelSetting.thresold <= user.experience_point
      total_exp -= levelSetting.thresold
      user.update(level: user.level += 1, experience_point: 0)
    end
    
    if user.level != 10
      until_percentage = total_exp.quo(levelSetting.thresold).to_f.round(2)*100
      until_level = levelSetting.thresold - total_exp
    end
    return {until_percentage: until_percentage, until_level: until_level}
  end
end