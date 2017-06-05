class Output
  require 'pry'

  def initialize
    @dependent_hash = {}
    @installed_components = []
    read_text
  end

  def process(command, components)
    if command == 'DEPEND' then depends(components)
    elsif command == 'INSTALL' then installs(command, components)
    elsif command == 'REMOVE' then removes(components)
    elsif command == 'LIST' then lists(components)
    else
      end_prog
    end
  end

  def depends(components)
    main_component = components.shift
    dependencies = components
    new_hash = {}
    new_hash[main_component] = dependencies
    @dependent_hash.merge!(new_hash)
  end

  def installs(command, component)
    if @installed_components.include? component
      puts ' ' + component + ' is already installed.'
    elsif @dependent_hash.key?(component[0])
      with_dependencies('add', component)
    else
      @installed_components << component[0]
      puts ' Installing ' + component[0].to_s
    end
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

  def with_dependencies(operation, component)
    @installed_components << component[0]
    puts ' Installing ' + component[0].to_s
    if operation == 'add'
      @dependent_hash[component[0]].each do |x|
        @installed_components << x
        puts ' Installing ' + x
      end
    else
      puts 'we are removing'
    end
  end

  def end_prog; end

  self
end.new
