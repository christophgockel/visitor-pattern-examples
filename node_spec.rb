require_relative 'node'

module Node
  describe Html do
    it "is a thing" do
      described_class.new
    end

    it "can contain other nodes" do
      html = Html.new
      html.add(Head.new)

      expect(html.children.count).to eq 1
    end
  end

  describe Head do
    it 'is a thing' do
      described_class.new
    end
  end

  describe Body do
    it 'is a thing' do
      described_class.new
    end
  end

  describe H1 do
    it 'is a thing' do
      described_class.new
    end
  end

  describe P do
    it 'is a thing' do
      described_class.new
    end
  end
end
