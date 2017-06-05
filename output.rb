class Output
  require 'pry'

  def initialize
    @dependent_hash = {}
    @installed_components = []
    read_text
  end

  def read_text
    File.open('input.txt').each do |line|
      puts line
      command = parse_command(line)
      components = parse_components(line)
      process(command, components)
    end
  end

  def parse_command(line)
    line.split.first
  end

  def parse_components(line)
    components_array = line.split
    components_array.shift
    components_array
  end

  def process(command, components)
    puts 'hello world'
    puts command
    puts components
    binding.pry
  end

  self
end.new
