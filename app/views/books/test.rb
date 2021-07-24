class Hoge
  def test
    @sample = 1
    puts @sample
  end
  
  def test2
    boxing = 2
  end

  def output
    puts @sample
  end

end

Hoge.new.output