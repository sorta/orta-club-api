class Member < ApplicationRecord

  before_validation :set_slug, on: [:create]

  validates :name_first, presence: true
  validates :slug, presence: true, uniqueness: true

  has_one :user

  private
    def set_slug
      candidate = self.name_first.to_s.parameterize
      exists = Member.exists?(slug: candidate)
      if exists
        if name_middle
          candidate = "#{candidate}-#{self.name_middle.to_s.parameterize}"

          exists = Member.exists?(slug: candidate)
          if exists
            candidate = try_number_slugs(candidate)
          end
        else
          candidate = try_number_slugs(candidate)
        end
      end
      self.slug = candidate
    end

    def try_number_slugs(previous)
      (2..10).each do |i|
        candidate = "#{previous}-#{i}"
        return candidate unless Member.exists?(slug: candidate)
      end
      previous
    end
end
