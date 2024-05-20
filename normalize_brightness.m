function normalized_image = normalize_brightness(img)
    % Convert the image to grayscale
    gray_img = rgb2gray(img);

    % Get the brightness level of the darker grains
    num_bins = 256;
    counts = imhist(gray_img, num_bins);
    cumulative_counts = cumsum(counts);
    total_pixels = numel(gray_img);
    threshold = 0.3 * total_pixels;
    dark_grain_brightness_level = find(cumulative_counts >= threshold, 1);

    % Calculate the scaling factor
    max_brightness = max(gray_img(:));
    scale_factor = double(dark_grain_brightness_level) / double(max_brightness);

    % Ensure the scale factor is not too low
    min_scale_factor = 0.1; % Adjust this value as needed
    scale_factor = max(scale_factor, min_scale_factor);

    % Adjust the brightness of the image
    adjusted_img = img * scale_factor;
    
    % Ensure the pixel values are within the valid range [0, 255]
    adjusted_img = min(max(adjusted_img, 0), 255);

    % Convert the adjusted image back to uint8
    normalized_image = uint8(adjusted_img);

    % Display the original and normalized images for comparison
    figure;
    subplot(1, 2, 1);
    imshow(img);
    title('Original Image');
    
    subplot(1, 2, 2);
    imshow(normalized_image);
    title('Normalized Image');
end
