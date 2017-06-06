require "caesar_cipher"

describe "caesar_cipher" do
  it "outputs 'Bcd ef Ghijklm'" do
    string = "Abc de Fghijkl"
    shift_factor = 1
    ciphered = "Bcd ef Ghijklm"
    expect(caesar_cipher(string, shift_factor)).to eq(ciphered)
  end

  it "outputs 'Iurp wlph wr wlph, Wkh forxgv jlyh uhvw, Wr wkh prrq-ehkroghuv.'" do
    string = "From time to time, The clouds give rest, To the moon-beholders."
    shift_factor = 3
    ciphered = "Iurp wlph wr wlph, Wkh forxgv jlyh uhvw, Wr wkh prrq-ehkroghuv."
    expect(caesar_cipher(string, shift_factor)).to eq(ciphered)
  end
end
