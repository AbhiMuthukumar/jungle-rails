module UserNameHelper

  def author (id)
    @author = User.find(id)
  end
end
