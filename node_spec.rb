require_relative 'node'

module Node
  context "Modules" do
    describe Container do
      subject { Class.new { include Container }.new }

      it "has no child nodes when created" do
        expect(subject.children.length).to eq 0
      end

      it "can have child nodes" do
        subject.add(double)

        expect(subject.children.length).to eq 1
      end
    end

    describe Visitable do
      subject { Class.new { include Visitable }.new }
      let(:visitor) { double(:visit) }

      it "accepts visitors" do
        expect(visitor).to receive(:visit).with(subject)

        subject.accept(visitor)
      end

      it "dispatches dynamically to the class specific method" do
        visitor = double(:visit_double)
        expect(visitor).to receive(:visit_double).with(subject)

        subject.accept(visitor)
      end
    end

    describe TextNode do
      subject { Class.new { include TextNode } }

      it "has no default text" do
        text_node = subject.new

        expect(text_node.content).to eq ""
      end

      it "can have text content" do
        text_node = subject.new("some text")

        expect(text_node.content).to eq "some text"
      end
    end
  end

  context "Classes" do
    [
      Html,
      Head,
      Title,
      Body,
      H1,
      P
    ].each do |klass|
      describe klass do
        it "acts as a container" do
          expect(klass.new).to be_a Container
        end

        it "acts as a visitable" do
          expect(klass.new).to be_a Visitable
        end
      end
    end

    [
      Title,
      H1,
      P
    ].each do |klass|
      describe klass do
        it "acts as text node" do
          expect(klass.new).to be_a TextNode
        end
      end
    end
  end
end
