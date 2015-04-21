require 'chunky_png'

GRADIENT_FILENAME = 'gradient.png'

class Color
	def initialize(r_value, g_value, b_value)
		@r_value = r_value
		@g_value = g_value
		@b_value = b_value
	end

	def get_color
		return @r_value, @g_value, @b_value
	end

	def to_s
		puts @r_value.to_s + ", " + @g_value.to_s + ", " + @b_value.to_s
	end
end

def calculate_gradient_colors(num_grades, start_color, end_color)
	grade_colors = []
	start_r, start_g, start_b = start_color.get_color
	end_r, end_g, end_b = end_color.get_color
	r_rate = (end_r - start_r) / num_grades.to_f
	g_rate = (end_g - start_g) / num_grades.to_f
	b_rate = (end_b - start_b) / num_grades.to_f
	num_grades.times do |x|
		grade_r = (start_r + (x * r_rate)).to_i
		grade_g = (start_g + (x * g_rate)).to_i
		grade_b = (start_b + (x * b_rate)).to_i
		grade_colors.push(Color.new(grade_r, grade_g, grade_b))
	end
	return grade_colors
end

def draw_image(gradient_colors, image_height)
	image_width = gradient_colors.size
	image = ChunkyPNG::Image.new(image_width, image_height, ChunkyPNG::Color::TRANSPARENT)
	gradient_colors.each_with_index do |color, i|
		r, g, b = color.get_color
		image_height.times do |j|
			image[i, j] = ChunkyPNG::Color.rgb(r, g, b)
		end
	end
	image.save(GRADIENT_FILENAME, :best_compression)
end

def get_gradient_info
	size = gets
	start_color = gets
	end_color = gets
	return size, start_color, end_color
end

def parse_gradient_info(size, start_color, end_color)
	width, height = size.split(" ")

	start_r, start_g, start_b = start_color.split(" ")
	start_color = Color.new(start_r.to_i, start_g.to_i, start_b.to_i)

	end_r, end_g, end_b = end_color.split(" ")
	end_color = Color.new(end_r.to_i, end_g.to_i, end_b.to_i)

	return width.to_i, height.to_i, start_color, end_color
end

def validate_gradient_info(width, height, start_color, end_color)
	raise "width must be greater than 0" if width <= 0
	raise "height must be greather than 0" if height <= 0
	[start_color, end_color].each do |color|
		r, g, b = color.get_color
		unless (r >= 0 and r <= 255) and (g >= 0 and g <= 255) and (b >= 0 and b <= 255)
			raise "Color components must fall between 0 and 255"
		end
	end
end

def create_gradient_image
	puts "Provide 3 lines of input for a new gradient!"
	size, start_color, end_color = get_gradient_info
	width, height, start_color, end_color = parse_gradient_info(size, start_color, end_color)
	validate_gradient_info(width, height, start_color, end_color)
	gradient_colors = calculate_gradient_colors(width, start_color, end_color)
	draw_image(gradient_colors, height)
	puts "Created gradient file " + GRADIENT_FILENAME + "!"
end

create_gradient_image
