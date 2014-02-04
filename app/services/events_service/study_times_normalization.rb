module EventsService

  class StudyTimesNormalization

    def initialize(timetable)
      @timetable = timetable
    end

    #TODO fix bug do agrupamento de blocos quando é para pomodoro
    def get_normalized
      grouped_sts = []
      #If the next block of availability is right after this and the productivity is the same,
      #we group the blocks to later divide then according the
      #block interval specified.
      @timetable.study_times.each_with_index do |st, i|
        last = grouped_sts.last
        if last.present? && st.day == last.day && (st.to + 1.minute) >= last.from && st.productivity == last.productivity

          #Merge the blocks
          last.to = st.to
        else
          grouped_sts << st

        end

      end

      new_sts = []
      grouped_sts.each do |st|
        blocks = number_of_blocks(st)

        #We truncate the number of blocks, so we only create complete blocks here
        blocks.truncate.times do |i|
          new_st = st.dup
          #In case it's the first block we use the original from's time
          #of the grouped (not normalized) study time, otherwise we get
          #the last block's to_time + interval
          if i != 0
            if @timetable.use_pomodoro_technique
              #Take a long break in case we alreay have 4 blocks, otherwise take a short break
              #First index is 0
              if (i+1) % 5 == 0
                new_st.from = new_sts.last.to + @timetable.pomodoro_technique.long_break_in_seconds
              else
                new_st.from = new_sts.last.to + @timetable.pomodoro_technique.short_break_in_seconds
              end
            else
              #No pomodoro technique, just use the normal interval provided
              new_st.from = new_sts.last.to + @timetable.block_interval_in_seconds
            end
          end

          new_st.to = new_st.from + @timetable.block_size_in_seconds
          new_sts << new_st
        end

        #If any incomplete block is left, we create it anyway
        #with what is left, unless we're using Pomodoro Technique,
        #since there's no incomplete Pomodoro
        if blocks % 1 > 0 && !@timetable.use_pomodoro_technique
          new_st = st.dup

          #If this incomplete block is not the only one that we have
          if blocks.truncate != 0
            new_st.from = new_sts.last.to + @timetable.block_interval_in_seconds
          end

          new_sts << new_st
        end

      end

      new_sts
    end

    private

    #Calcula o número de blocos de estudo a partir de um bloco
    #de estudo agrupado.
    #Considera também o intervalo informado e o caso onde o usuário
    #escolhe usar a técnica de pomodoro para definir o tamanho dos blocos
    #e progressão dos intervalos.
    def number_of_blocks(grouped_study_time)
      if @timetable.use_pomodoro_technique
        blocks = grouped_study_time.duration_in_seconds / (@timetable.block_size_in_seconds + @timetable.pomodoro_technique.short_break_in_seconds)
        #Precisamos considerar que a cada 4 blocos há uma pausa maior (long break)
        if blocks > 4
          long_breaks = (blocks / 5).truncate
          blocks -= long_breaks * @timetable.pomodoro_technique.long_break_in_seconds
        end
      else
        blocks = grouped_study_time.duration_in_seconds / (@timetable.block_size_in_seconds + @timetable.block_interval_in_seconds)
      end

      blocks
    end

  end
end
