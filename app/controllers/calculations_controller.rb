class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @text_array = @text.downcase.gsub(/[^a-z0-9\s]/i, "").split

    @word_count = @text_array.count

    @character_count_with_spaces = @text.length

    @text_no_spaces = @text.gsub(" ","")

    @character_count_without_spaces = @text_no_spaces.length

    @occurrences = 0

    @text_array.each do |word|
      if word == @special_word.downcase
        @occurrences = @occurrences + 1
      end
    end


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @r = @apr / 12 / 100 # monthly percentage rate = APR divided by 12 (converted to percentage)
    @n = @years * 12 # number of monthly payments = years times 12

    if @r == 0
      @monthly_payment = @principal
    else
      @monthly_payment = (@r*@principal*(1+@r)**@n)/((1+@r)**@n - 1)
    end

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds / 60.0
    @hours = @seconds / 3600.0
    @days = @seconds / 86400.0
    @weeks = @seconds / 604800.0
    @years = @seconds / 31536000.0

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers.reverse[0]

    @range = @maximum - @minimum

    @length = @numbers.length

    if @length.odd?
      @median_position = (@length - 1)/2
      @median = @sorted_numbers[@median_position]
    else
      @median_right = @length / 2
      @median_left = @median_right - 1
      @median = (@sorted_numbers[@median_left] + @sorted_numbers[@median_right])/2
    end

    @sum = 0
    @numbers.each do |num|
      @sum = @sum + num
    end

    @mean = @sum / @count

    @sum_of_squares = 0

    @numbers.each do |num|
      square = num ** 2
      @sum_of_squares = @sum_of_squares + square
    end

    @variance = (@sum_of_squares / @length) - @mean**2

    @standard_deviation = @variance ** 0.5

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
