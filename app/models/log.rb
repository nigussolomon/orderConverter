# frozen_string_literal: true

class Log < ApplicationRecord
  validates :message, presence: true
end
