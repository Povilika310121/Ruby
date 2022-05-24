current_path = File.dirname(__FILE__)
require 'yaml'
require "#{current_path}/Department.rb"

class Department_list < Department
    def initialize(*dep_list)  # * - Передача произвольного числа аргументов в метод
      @dep_list = dep_list
    end

    def add_note(dep)
        if dep.class.name == "Array"
            dep.length.times do |index|
                @dep_list.append(dep[index])
            end
        else
            @dep_list.append(dep)
        end
    end

    def choose_note(index)
        @index = index - 1
    end

    def change_note(new_dep)
        @dep_list[@index] = new_dep
    end

    def get_note
        @dep_list[@index]
    end

    def delete_note
        @dep_list.delete_at(@index)
        @index-=1
    end

    def Department_list.read_from_txt(file_name)
        file = File.new(file_name + ".txt", "r")
        (file.read.split(/~\n/).map { |object_str| object_str.split(/\n/) }).map { |object| object = Department.new(object.shift, object.shift, object)}
        #shift возвращает элемент массива и удаляет его
    end

    def Department_list.write_to_txt(array, file_name)
        output = File.new(file_name + ".txt", "w")
        output.puts array.map { |object| object = ([] << object.name << object.phone_number << object.duties).join("\n") }.join("\n~\n")
        output.close()
    end

    def Department_list.write_to_YAML(array, file_name)
        require 'yaml'
        output = File.new(file_name + ".yaml", "w")
        YAML.dump(array, output)
        output.close()
    end

    def Department_list.read_from_YAML(file_name)
        require 'yaml'
        YAML.load_file (file_name + ".yaml"), permitted_classes: [Department]
    end

    def to_s()
        s = ""
        @dep_list.length.times do |index|
            if @dep_list[index].duties.empty?
                s+= "##{index + 1}\n\tName: #{@dep_list[index].name}\n\tPhone: #{@dep_list[index].phone_number}\n"
            else
                s+= "##{index + 1}\n\tName: #{@dep_list[index].name}\n\tPhone: #{@dep_list[index].phone_number}\n\tDuties: \n\t"
                @dep_list[index].duties.each_index { |i| s+= "\t #{i+1}. #{@dep_list[index].duties[i]}\n\t" } 
            end
            s+="\n"  
        end
        s
    end

    def sort()
        @dep_list.sort! {|a, b| a.name <=> b.name}
    end

end


from_yaml=Department_list.read_from_YAML("output_yaml")
list_dep = Department_list.new()
list_dep.add_note(from_yaml)
puts list_dep.sort


# ktoto = Department.new('Ktoto', '+7-901-013-42-31')
# ktoto.add_duty("1")
# ktoto.add_duty("2")
# ktoto.add_duty("3")
# list_dep.add_note(ktoto)
# puts list_dep
# list_dep.choose_note(2)
# list_dep.delete_note
# Department.write_to_YAML(from_yaml, "output_yaml")
# puts Department.read_from_YAML("output_yaml")
# danna = Department.new("Danna", "+79009053535")
# vika.highligth(3)
# vika.replace_highligth_duty("учиться всю ночь")
# puts vika, danna
# Department.write_to_txt(from_txt, "output")
# Department.write_to_txt([vika, danna], "output")
