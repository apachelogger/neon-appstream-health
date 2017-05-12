require_relative 'test_helper'

require 'open-uri'

class DEP11Test < Minitest::Test
  SERIES = 'xenial'.freeze
  POCKETS = %w[main].freeze

  def test_user
    inreleas_uri = "https://archive.neon.kde.org/user/dists/#{SERIES}/InRelease"
    wanted_pockets = POCKETS.dup
    open(inreleas_uri) do |f|
      f.each_line do |line|
        pocket = wanted_pockets.find { |x| line.include?("#{x}/dep11") }
        next unless pocket
        p pocket
        wanted_pockets.delete(pocket)
      end
    end
    assert_equal([], wanted_pockets, 'Some pockets are in need of dep11 data.')
  end

  def test_user_lts
    inreleas_uri =
      "https://archive.neon.kde.org/user/lts/dists/#{SERIES}/InRelease"
    wanted_pockets = POCKETS.dup
    open(inreleas_uri) do |f|
      f.each_line do |line|
        pocket = wanted_pockets.find { |x| line.include?("#{x}/dep11") }
        next unless pocket
        p pocket
        wanted_pockets.delete(pocket)
      end
    end
    assert_equal([], wanted_pockets, 'Some pockets are in need of dep11 data.')
  end
end
