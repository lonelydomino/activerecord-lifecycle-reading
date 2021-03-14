

class Post < ActiveRecord::Base

  belongs_to :author
  validate :is_title_case 

#  Here is a rule of thumb: **Whenever you are modifying an attribute of the
#  model, use `before_validation`. If you are doing some other action, then use
# `before_save`.**

  before_validation :make_title_case

# before_save :make_title_case
before_save :email_author_about_post
#   We use `before_save` for actions that need to occur that aren't
# modifying the model
# itself.

  private

  def is_title_case
    if title.split.any?{|w|w[0].upcase != w[0]}
      errors.add(:title, "Title must be in title case")
    end
  end

  def make_title_case
    self.title = self.title.titlecase
  end
  def email_author_about_post
    # Not implemented.
    # For more information: https://guides.rubyonrails.org/action_mailer_basics.html
  end
end
# Before you move on, let's cover one last callback that is useful:
# `before_create`. `before_create` is very close to `before_save` with one major
# difference: it only gets called when a model is created for the first time.
# This means not every time the object is persisted, just when it is **new**.