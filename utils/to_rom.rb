
obj = File.binread('bin/starfield.o')

words   = obj.unpack("C*")
state   = :SEEKING_START_LO
segment = {}
out     = []
words[2..-1].each_with_index do |word, i|
    if state == :CODE and i > (segment[:end] - segment[:start])
        state = :SEEKING_START_LO
    end

    case state
        when :SEEKING_START_LO
            segment[:start_lo] = word
            state = :SEEKING_START_HI
        when :SEEKING_START_HI
            segment[:start_hi] = word
            state = :SEEKING_END_LO
        when :SEEKING_END_LO
            segment[:end_lo] = word
            state = :SEEKING_END_HI
        when :SEEKING_END_HI
            segment[:end_hi] = word
            state = :CODE
            segment[:start] = segment[:start_hi]*256 + segment[:start_lo]
            segment[:end]   = segment[:end_hi]*256 + segment[:end_lo]
            (segment[:start]..segment[:end]).each do
                out << 0x00
            end
        when :CODE
            out << word
    end
end

File.open('bin/starfield.nes', 'wb') do |f|
    f.write(out.pack("S*"))
end
