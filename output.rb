class Output
  require 'pry'

  def initialize
    @dependent_hash = {}
    @installed_components = []
    read_text
  end

  def process(command, components)
    if command == 'DEPEND' then depends(command, components)
    elsif command == 'INSTALL' then installs(command, components)
    elsif command == 'REMOVE' then removes(components)
    elsif command == 'LIST' then lists(components)
    else
      end_prog
    end
  end

  def depends(command, components)
    puts 'depending' + components.to_s
    binding.pry
    # add to @dependents_hash
  end

  def installs(command, components)
    puts 'installing'
    # check if components already installed
    # add components to @installed_components
    # puts output message " Installing " + component
  end

  def removes(components)
    puts 'removing'
    # checks if components already installed_components
    # checks if components is val to any other component key in @dependents_hash
    # checks if component key is in @installed_components
    # removes from component from @installed_components
  end

  def lists(components)
    puts 'listing'
    # puts all @installed_components
  end

  private

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

  def end_prog; end

  self
end.new
