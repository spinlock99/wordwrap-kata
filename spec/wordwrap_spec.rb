require 'spec_helper'
require 'wordwrap'

describe Wordwrap do
  describe "#initialize" do
    shared_examples "raise exception" do
      specify { expect { subject }.to raise_exception }
    end

    context "with wrap as an integer" do
      subject(:wordwrap) { Wordwrap.new(5) }
      it "instantiates" do
        expect { wordwrap }.to_not raise_exception
      end
      it { should respond_to(:wrap) }
    end
    context "with no argument" do
      subject(:wordwrap) { Wordwrap.new() }

      it_behaves_like "raise exception"
    end
    context "with a string argument" do
      subject(:wordwrap) { Wordwrap.new("foo") }

      it_behaves_like "raise exception"
    end
  end

  describe ".wrap" do
    context "wrap at 5 characters" do
      subject(:wordwrap) { Wordwrap.new(5) }

      context "with a string parameter" do
        let(:wrap) { wordwrap.wrap("word word") }

        specify { expect { wrap }.to_not raise_exception }
        it { wrap.should eq("word\nword") }
      end
      context "with a longer string parameter" do
        let(:wrap) { wordwrap.wrap("word word word") }

        it { wrap.should eq("word\nword\nword") }
      end
      context "with an array parameter" do
        let(:wrap) { wordwrap.wrap([1,2,3,4]) }

        it { expect { wrap }.to raise_exception }
      end
      context "with an empty string parameter" do
        let(:wrap) { wordwrap.wrap("") }

        it { wrap.should eq("") }
      end
      context "with a one word string parameter" do
        let(:wrap) { wordwrap.wrap("word") }

        it { wrap.should eq("word") }
      end
      context "with a longword" do
        let(:wrap) { wordwrap.wrap("wordword") }

        it { wrap.should eq("wordw\nord") }
      end
    end
    context "wrap at 10 characters" do
      subject(:wordwrap) { Wordwrap.new(10) }
      let(:wrap) { wordwrap.wrap("word word word") }

      it { wrap.should eq("word word\nword") }
    end
    context "wrap at 3 characters" do
      subject(:wordwrap) { Wordwrap.new(3) }
      let(:wrap) { wordwrap.wrap("word word word") }

      it { wrap.should eq("wor\nd\nwor\nd\nwor\nd") }
    end
  end
end
