class Output
  require 'pry'

  def initialize
    @dependent_hash = {}
    @installed_components = []
    read_text
  end

  def process(command, components)
    if command == 'DEPEND' then depends(components)
    elsif command == 'INSTALL' then installs(components)
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

  def installs(component)
    if @installed_components.include? component[0].to_s
      puts ' ' + component[0].to_s + ' is already installed.'
    elsif @dependent_hash.key?(component[0])
      add_with_dependencies(component)
    else
      @installed_components << component[0]
      puts ' Installing ' + component[0].to_s
    end
  end

  def removes(component)
    if !@installed_components.include? component[0]
      puts ' ' + component[0] + ' is not installed'
    elsif @dependent_hash.key?(component[0])
      remove_with_dependencies(component)
    # checks if components is val to any other component key in @dependents_hash
    # checks if component key is in @installed_components
    # removes from component from @installed_components
    elsif !dependent_to_installed(component[0])
      @installed_components.delete(component[0])
      puts ' Removing ' + component[0]
    else
      puts ' Can not remove ' + component[0]
    end
  end

  def lists(components)
    puts @installed_components
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

  def add_with_dependencies(component)
    @installed_components << component[0]
    puts ' Installing ' + component[0].to_s
    @dependent_hash[component[0]].each do |x|
      if @installed_components.include? x
        puts ' ' + x + ' is already installed.'
      else
        @installed_components << x
        puts ' Installing ' + x
      end
    end
  end

  def remove_with_dependencies(component)
    @installed_components.delete(component[0])
    puts ' Removing!! ' + component[0].to_s
    @dependent_hash[component[0]].each do |x|
      if !dependent_to_installed(x)
        @installed_components.delete(x)
        puts ' REMOVING!!!!!! ' + x
      end
    end
  end

  def dependent_to_installed(component)
    # check for if component is value in the dependent_hash
    # and key is currently in @installed_components
  end

  def end_prog; end

  self
end.new
