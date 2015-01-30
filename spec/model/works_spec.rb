require_relative "../spec_helper.rb"

describe "Works" do

  let!(:works_mixed) { Works.new([
    build(:work, :nikon_d80),
    build(:work, :canon_snappy),
    build(:work, :canon_d80),
    build(:work, :canon_snappy)
    ])}

  let!(:works_many) { Works.new( build_list(:work, 14, :canon_snappy) ) }


  it "holds all the images" do
    expect(works_many.images.size).to eq(14)
  end

  it "determines unique camera makes" do
    expect(works_mixed.unique_makes).to eq(["Canon", "Nikon"])
  end

  it "determines unique camera models for a camera make" do
    expect(works_mixed.unique_models_for_make("Canon")).to eq(["D80", "Snappy"])
    expect(works_mixed.unique_models_for_make("Nikon")).to eq(["D80"])
  end


end
