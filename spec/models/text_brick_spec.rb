require 'spec_helper'

describe Kuhsaft::TextBrick do

  let :text_brick do
    Kuhsaft::TextBrick.new
  end

  describe '#bricks' do
    it 'can not have childs' do
      text_brick.should_not respond_to(:bricks)
    end
  end

  describe '#user_can_add_childs?' do
    it 'returns false' do
      text_brick.user_can_add_childs?.should be_false
    end
  end
end