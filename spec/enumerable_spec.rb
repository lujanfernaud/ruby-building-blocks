require "enumerable"

describe Enumerable do
  let(:array) { [1, 3, 5, 6, 7, 9, 14, 21] }

  describe "#my_each" do
    context "with a block" do
      it "returns itself" do
        expect(array.my_each { |n| n }).to eq(array)
      end

      it "prints its elements" do
        expect { array.my_each { |n| print n, " - " } }
          .to output("1 - 3 - 5 - 6 - 7 - 9 - 14 - 21 - ").to_stdout
      end
    end

    context "without a block" do
      it "returns enumerator" do
        expect(array.my_each).to be_an(Enumerator)
      end
    end
  end

  describe "#my_each_with_index" do
    context "with a block" do
      it "returns itself" do
        expect(array.my_each_with_index { |n| n }).to eq(array)
      end

      it "prints elements indexes" do
        expect { array.my_each_with_index { |_n, index| print index, " - " } }
          .to output("0 - 1 - 2 - 3 - 4 - 5 - 6 - 7 - ").to_stdout
      end
    end

    context "without a block" do
      it "returns enumerator" do
        expect(array.my_each_with_index).to be_an(Enumerator)
      end
    end
  end

  describe "#my_select" do
    context "with a block" do
      it "returns itself" do
        expect(array.my_select { |n| n }).to eq(array)
      end

      it "returns array with elements for which the block returns true" do
        expect(array.my_select { |n| n < 14 }).to eq([1, 3, 5, 6, 7, 9])
      end
    end

    context "without a block" do
      it "returns enumerator" do
        array = [1, 2, 3]
        expect(array.my_select).to be_an(Enumerator)
      end
    end
  end

  describe "#my_all?" do
    context "when all elements meet the required condition" do
      it "returns 'true'" do
        expect(array.my_all? { |n| n < 100 }).to be(true)
      end
    end

    context "when not all elements meet the required condition" do
      it "returns 'false'" do
        expect(array.my_all? { |n| n < 20 }).to be(false)
      end
    end
  end

  describe "#my_any?" do
    context "when an element meets the required condition" do
      it "returns 'true'" do
        expect(array.my_any? { |n| n.odd? }).to be(true)
      end
    end

    context "when not a single element meets the required condition" do
      it "returns 'false'" do
        expect(array.my_any? { |n| n > 100 }).to be(false)
      end
    end
  end

  describe "#my_none?" do
    context "when none of the elements meet the required condition" do
      it "returns 'true'" do
        expect(array.my_none? { |n| n == 99 }).to be(true)
      end
    end

    context "when some of the elements meet the required condition" do
      it "returns 'false'" do
        expect(array.my_none? { |n| n < 3 }).to be(false)
      end
    end
  end

  describe "#my_count" do
    context "without argument and block" do
      it "returns number of elements" do
        expect(array.count).to eq(8)
      end
    end

    context "with argument" do
      it "counts the number of elements which equal obj using ==" do
        expect(array.count(9)).to eq(1)
      end
    end

    context "with block" do
      it "counts the number of elements for which the block returns true" do
        expect(array.count { |n| n > 20 }).to eq(1)
      end
    end
  end

  describe "#my_map" do
    context "with a block" do
      it "creates a new array containing the values returned by the block" do
        expect(array.my_map { |n| n if n.odd? })
          .to eq([1, 3, 5, nil, 7, 9, nil, 21])
      end
    end

    context "without a block" do
      it "returns an enumerator" do
        expect(array.my_map).to be_an(Enumerator)
      end
    end
  end

  describe "#my_inject" do
    context "with initial value and symbol" do
      it "applies operation specified by symbol starting on initial value" do
        expect(array.my_inject(3, :+)).to eq(69)
      end
    end

    context "with symbol" do
      it "applies operation specified by symbol" do
        expect(array.my_inject(:+)).to eq(66)
      end
    end

    context "with initial value and block" do
      it "applies operation specified by block starting on initial value" do
        expect(array.my_inject(3) { |product, n| product * n })
          .to eq(5_000_940)
      end
    end

    context "with block" do
      it "applies operation specified by block" do
        expect(array.my_inject { |sum, n| sum + n }).to eq(66)
      end
    end
  end
end
