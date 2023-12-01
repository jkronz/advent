class Directory
  attr_accessor :name, :children, :files, :parent  

  def initialize(name, parent)
    @name = name
    @parent = parent
    @children = []
    @files = []
  end

  def size
    @size ||= files.sum(&:size) + children.sum(&:size)
  end

  def add_file(file)
    files << file
  end

  def add_child(dir)
    children << dir
  end

  def <=>(other)
    size <=> other.size
  end

  def pretty_print(indent_level = 0)
    spaces = " " * (indent_level * 2)
    puts "#{spaces} - #{name} (dir, size=#{size})"
    children.each { |dir| dir.pretty_print(indent_level + 1)}
    files.each do |f|      
      spaces = " " * ((indent_level + 1) * 2)
      puts "#{spaces} - #{f.name} (file, size=#{f.size})"
    end
  end
end

class DataFile
  attr_accessor :name, :size

  def initialize(name, size)
    @name = name
    @size = size.to_i
  end
end

root = Directory.new('/', nil)
cwd = root
directories = [cwd]
stack = []
File.readlines('input.txt').each do |line|
  if line.start_with?('dir')
    name = line.split(' ')[1]
    directory = Directory.new(name, cwd)
    directories << directory
    cwd.add_child(directory)
  elsif line.start_with?('$ cd')
    where_to = line.split(' ')[2]    
    case where_to
    when '/'
      cwd = root
    when '..'
      cwd = cwd.parent || root
    else
      cwd = cwd.children.find { |child| child.name == where_to }
    end
  elsif line.start_with?('$ ls')
    # nothing to do here..
  else #
    size, name = line.split(' ')
    df = DataFile.new(name, size)
    cwd.add_file(df)
  end
end

root.pretty_print
small_directories = directories.select { |dir| dir.size <= 100000 }
puts small_directories.map(&:name).to_s
puts small_directories.sum(&:size)

DISK_SIZE = 70000000
REQUIRED = 30000000
free_space = DISK_SIZE - root.size
space_needed = REQUIRED - free_space
puts "Freed: #{directories.select { |dir| dir.size >= space_needed }.sort.first.size}"