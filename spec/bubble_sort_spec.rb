require "bubble_sort"

describe "bubble_sort" do
  it "sorts without receiving a block" do
    array  = [7, 4, 16, 3, 78, 5, 2, 0, 9, 2, 21]
    sorted = [0, 2, 2, 3, 4, 5, 7, 9, 16, 21, 78]
    expect(bubble_sort(array)).to eq(sorted)
  end
end

describe "bubble_sort_by" do
  it "sorts receiving a block" do
    array  = %w[hi hello tashi-delek hey hola szia konnichiwa]
    sorted = %w[hi hey hola szia hello konnichiwa tashi-delek]
    expect(bubble_sort_by(array) { |a, b| a.length - b.length }).to eq(sorted)
  end
end
