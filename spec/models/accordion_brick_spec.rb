require 'spec_helper'

describe Kuhsaft::AccordionBrick do

  let :accordion_brick do
    Kuhsaft::AccordionBrick.new
  end

  describe '#user_can_delete?' do
    it 'returns true' do
      accordion_brick.user_can_delete?.should be_true
    end
  end

  describe '#renders_own_childs?' do
    it 'returns false' do
      accordion_brick.renders_own_childs?.should be_false
    end
  end

  describe '#bricks' do
    it 'can have childs' do
      accordion_brick.should respond_to(:bricks)
    end
  end

  describe '#to_style_class' do
    it 'includes the bootstrap classname' do
      accordion_brick.to_style_class.should == 'kuhsaft-accordion-brick accordion'
    end
  end

  describe '#allowed_brick_types' do
    it 'only allows AccordionItems' do
      accordion_brick.allowed_brick_types.should == %w(Kuhsaft::AccordionItemBrick)
    end
  end
end
