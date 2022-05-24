class Department
    
    attr_accessor :name, :duties #attr_accessor геттер и сеттор одновременно
    attr_reader :phone_number
    def initialize(name, phone_number,  duties = [])
        @name = name
        self.phone_number = phone_number
        @duties = duties
    end

    def phone_number=(phone_number)
        if Department.check_phone?(phone_number)
          @phone_number = phone_number
        else raise ArgumentError.new("#{phone_number} не номер телефона!")
        end
    end

    def Department.check_phone?(phone_number)
        /\+7([.-]?)([0-9]{3})([.-]?)([0-9]{3})([.-]?)([0-9]{2})([.-]?)([0-9]{2})/ =~ phone_number
      end

    def add_duty(duty)
        @duties <<duty
    end

    def highligth(ind)
        @highligth_duty = ind - 1
    end

    def del_duties(ind)
        @duties.delete_at(ind-1)
    end

    def highligth_read()
        @duties[@highligth_duty]
    end

    def replace_highligth_duty(text)
        @duties[@highligth_duty] = text
    end

    def to_s
        if @duties.empty?
            s = "Name: #{@name}\nPhone: #{@phone_number}\n"
        else
            s = "Name: #{@name}\nPhone: #{@phone_number}\nDuties: \n"
            @duties.each_index { |i| s += "\t #{i+1}. #{@duties[i]}\n" } 
        end
        s + "\n"
    end
  
end
