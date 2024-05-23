-- setting the charset
SET NAMES utf8mb4;

-- saving original SQL mode settings
SET @OLD_SQL_MODE=@@SQL_MODE;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;

-- setting desired SQL mode
SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET UNIQUE_CHECKS=0, FOREIGN_KEY_CHECKS=0;

-- selecting database

USE serokuatro_prod;

INSERT INTO members (first_name, last_name, pronouns, email, phone, role_id, department_id, studio_id) VALUES
('Alejandro', 'García', 'he/him', 'alejandro@gmail.com', '+549112345678', 1, 1, 1),
('Sofía', 'Martínez', 'she/her', 'sofia@yahoo.com', '+549112345678', 2, 1, 1),
('Diego', 'Hernández', 'he/him', 'diego@hotmail.com', '+549112345678', 3, 2, 1),
('Valentina', 'López', 'she/her', 'valentina@gmail.com', '+549112345678', 4, 1, 1),
('Lucas', 'Rodríguez', 'he/him', 'lucas@yahoo.com', '+549112345678', 5, 3, 2),
('María', 'Gutiérrez', 'she/her', 'maria@hotmail.com', '+549112345678', 6, 6, 2),
('Carlos', 'Díaz', 'he/him', 'carlos@gmail.com', '+549112345678', 7, 4, 2),
('Elena', 'Pérez', 'she/her', 'elena@yahoo.com', '+549112345678', 8, 4, 3),
('Javier', 'Sanchez', 'he/him', 'javier@hotmail.com', '+549112345678', 9, 6, 3),
('Laura', 'Fernández', 'she/her', 'laura@gmail.com', '+549112345678', 10, 7, 3);

INSERT INTO roles (role_name, department_id) VALUES
('Director', 1),
('Producer', 1),
('Gaffer', 2),
('Assistant Producer', 1),
('Cinematographer', 3),
('Editor', 6),
('Sound Designer', 4),
('Screenwriter', 4),
('Composer', 6),
('Makeup Artist', 7);

INSERT INTO departments (department_name, department_head_id) VALUES
('Production', 1),
('Lighting', 3),
('Photography', 5),
('Sound', 7),
('Music', 9),
('Post', 11),
('Dress & Makeup', 13),
('Legal', 15),
('Finance', 17),
('Security', 19);

INSERT INTO studios (studio_name, contact_phone, studio_email, city, country, facilities, capacity, available) VALUES
('BigFilm Studio', '+549112345678', 'info@bigfilm.com', 'Buenos Aires', 'Argentina', 'Green screen, editing rooms', 5, TRUE),
('SmallScreen Studio', '+549112345678', 'info@smallscreen.com', 'Cordoba', 'Argentina', 'Sound stage, lighting equipment', 3, TRUE),
('Studio Cinéma', '+549112345678', 'info@studiocinema.com', 'Rosario', 'Argentina', 'Soundproof stages, editing suites', 6, TRUE),
('Starlight Studios', '+549112345678', 'info@starlight.com', 'Mendoza', 'Argentina', 'Large soundstage, post-production facilities', 8, TRUE),
('Silver Screen Studios', '+549112345678', 'info@silverscreen.com', 'Buenos Aires', 'Argentina', 'Multiple sound stages, green rooms', 10, TRUE),
('Golden Globe Studios', '+549112345678', 'info@goldenglobe.com', 'La Plata', 'Argentina', 'State-of-the-art production facilities', 15, TRUE),
('Sunrise Studios', '+549112345678', 'info@sunrise.com', 'Salta', 'Argentina', 'Film and TV production services', 6, TRUE),
('Moonlight Studios', '+549112345678', 'info@moonlight.com', 'San Juan', 'Argentina', 'Professional sound stages, editing suites', 7, TRUE),
('Starry Night Studios', '+549112345678', 'info@starrynight.com', 'Corrientes', 'Argentina', 'High-tech sound stages, lighting equipment', 9, TRUE),
('Sunset Studios', '+549112345678', 'info@sunset.com', 'Santa Fe', 'Argentina', 'Modern filming facilities, soundproof stages', 12, TRUE);

INSERT INTO projects (title, description, type, release_date, studio_id, scale, stage) VALUES
('Inception', 'A mind-bending heist movie set within the architecture of the mind.', 'Film', '2024-01-01', 1, 'Medium', 'Pre-production'),
('Stranger Things Season 4', 'The beloved Netflix series returns with more supernatural adventures in the Upside Down.', 'TV Show', '2024-02-01', 2, 'Large', 'Production'),
('Bohemian Rhapsody', 'A biographical film about the British rock band Queen, focusing on lead singer Freddie Mercury.', 'Music Video', '2024-03-01', 3, 'Small', 'Post-production'),
('The Dark Knight Rises', 'The final installment in Christopher Nolan\'s Batman trilogy, featuring the epic showdown between Batman and Bane.', 'Film', '2024-04-01', 4, 'Medium', 'Pre-production'),
('Game of Thrones Season 9', 'The epic fantasy series continues its saga of power, politics, and dragons in the Seven Kingdoms.', 'TV Show', '2024-05-01', 5, 'Large', 'Production'),
('Thriller', 'A groundbreaking music video directed by John Landis, featuring Michael Jackson\'s iconic dance moves and horror-themed narrative.', 'Music Video', '2024-06-01', 1, 'Small', 'Post-production'),
('Interstellar', 'A sci-fi epic exploring space travel, time dilation, and the survival of humanity on a distant planet.', 'Film', '2024-07-01', 2, 'Medium', 'Pre-production'),
('Breaking Bad: The Movie', 'A feature-length film based on the acclaimed TV series, following the transformation of Walter White from high school chemistry teacher to methamphetamine kingpin.', 'TV Show', '2024-08-01', 3, 'Large', 'Production'),
('Despacito', 'The most-viewed music video on YouTube, featuring Luis Fonsi and Daddy Yankee performing their chart-topping hit.', 'Music Video', '2024-09-01', 4, 'Small', 'Post-production'),
('Avatar 2', 'The highly anticipated sequel to James Cameron\'s blockbuster film, set on the moon Pandora and exploring themes of environmentalism and indigenous culture.', 'Film', '2024-10-01', 5, 'Medium', 'Pre-production');

INSERT INTO distribution_channels (channel_name, channel_type, exclusive_licensing, fee_type, contact_name, contact_phone, contact_email, region, licensing_details, website, notes) VALUES
('Silver Screens', 'Theatrical', TRUE, 'FA', 'John Smith', '+549112345678', 'john@silverscreens.com', 'International', 'Exclusive rights for theatrical distribution.', 'www.silverscreens.com', NULL),
('Streamline', 'Streaming', FALSE, 'PER', 'Emma Johnson', '+549112345678', 'emma@streamline.com', 'Global', 'Per title licensing agreements.', 'www.streamline.com', NULL),
('Prime TV', 'Television', TRUE, 'FA', 'Daniel Garcia', '+549112345678', 'daniel@primetv.com', 'Latin America', 'Exclusive broadcasting rights.', 'www.primetv.com', NULL),
('Global Cinema', 'Theatrical', TRUE, 'FA', 'Sophia Lee', '+549112345678', 'sophia@globalcinema.com', 'Worldwide', 'Exclusive distribution in theaters worldwide.', 'www.globalcinema.com', NULL),
('FlixNet', 'Streaming', FALSE, 'PER', 'Alex Wang', '+549112345678', 'alex@flixnet.com', 'Asia Pacific', 'Subscription-based streaming service.', 'www.flixnet.com', NULL),
('TV Plus', 'Television', TRUE, 'FA', 'Miguel Santos', '+549112345678', 'miguel@tvplus.com', 'Europe', 'Exclusive broadcasting deals with major networks.', 'www.tvplus.com', NULL),
('Home Entertainment', 'Home Video', FALSE, 'PER', 'Isabella Rossi', '+549112345678', 'isabella@homeentertainment.com', 'North America', 'DVD and Blu-ray distribution.', 'www.homeentertainment.com', NULL),
('Digital Cinema', 'Theatrical', TRUE, 'FA', 'David Kim', '+549112345678', 'david@digitalcinema.com', 'Global', 'Digital projection solutions for cinemas.', 'www.digitalcinema.com', NULL),
('CineMax', 'Theatrical', TRUE, 'FA', 'Lucas Oliveira', '+549112345678', 'lucas@cinemax.com', 'Latin America', 'Premium cinema experience.', 'www.cinemax.com', NULL);

INSERT INTO contracts (contract_type, start_date, end_date, terms, project_id, member_id) VALUES
('FPA', '2024-06-01', '2024-12-31', 'Exclusive rights to film production.', 1, 1),
('IPA', '2024-07-01', '2024-12-31', 'Exclusive rights to music composition.', 3, 9),
('DA', '2024-08-01', '2024-12-31', 'Exclusive rights to theatrical distribution.', 4, 10),
('FPA', '2024-09-01', '2024-12-31', 'Exclusive rights to film production.', 5, 6),
('IPA', '2024-10-01', '2024-12-31', 'Exclusive rights to music composition.', 7, 2),
('DA', '2024-11-01', '2024-12-31', 'Exclusive rights to theatrical distribution.', 8, 8),
('FPA', '2024-12-01', '2024-12-31', 'Exclusive rights to film production.', 10, 1),
('IPA', '2025-01-01', '2024-12-31', 'Exclusive rights to music composition.', 9, 2),
('DA', '2025-02-01', '2024-12-31', 'Exclusive rights to theatrical distribution.', 14, 6),
('FPA', '2025-03-01', '2024-12-31', 'Exclusive rights to film production.', 10, 4);

INSERT INTO financial_transactions (transaction_date, transaction_type, amount, description, project_id) VALUES
('2024-01-01', 'Income', 5000.00, 'Ticket sales revenue for Inception', 1),
('2024-02-01', 'Income', 6000.00, 'Licensing revenue for Stranger Things Season 4', 2),
('2024-03-01', 'Income', 7000.00, 'Royalties from Bohemian Rhapsody soundtrack', 3),
('2024-04-01', 'Income', 8000.00, 'Box office earnings for The Dark Knight Rises', 4),
('2024-05-01', 'Income', 9000.00, 'Streaming revenue for Game of Thrones Season 9', 5),
('2024-06-01', 'Income', 10000.00, 'Music video sales for Thriller', 6),
('2024-07-01', 'Income', 11000.00, 'International distribution sales for Interstellar', 7),
('2024-08-01', 'Income', 12000.00, 'Broadcast rights revenue for Breaking Bad: The Movie', 8),
('2024-09-01', 'Income', 13000.00, 'Advertising revenue for Despacito', 9),
('2024-10-01', 'Income', 14000.00, 'Merchandise sales for Avatar 2', 10),
('2024-01-02', 'Expense', 1000.00, 'Production costs for Inception', 1),
('2024-02-02', 'Expense', 2000.00, 'Special effects budget for Stranger Things Season 4', 2),
('2024-03-02', 'Expense', 3000.00, 'Marketing expenses for Bohemian Rhapsody', 3),
('2024-04-02', 'Expense', 4000.00, 'Set design costs for The Dark Knight Rises', 4),
('2024-05-02', 'Expense', 5000.00, 'Actor salaries for Game of Thrones Season 9', 5),
('2024-06-02', 'Expense', 6000.00, 'Director\'s fee for Thriller', 6),
('2024-07-02', 'Expense', 7000.00, 'Location scouting expenses for Interstellar', 7),
('2024-08-02', 'Expense', 8000.00, 'Legal fees for Breaking Bad: The Movie', 8),
('2024-09-02', 'Expense', 9000.00, 'Music video production costs for Despacito', 9),
('2024-10-02', 'Expense', 10000.00, 'Special effects budget for Avatar 2', 10);

INSERT INTO member_payroll (member_id, transaction_id, amount) VALUES
(1, 1, 2000.00),
(2, 2, 3000.00),
(3, 3, 4000.00),
(4, 4, 5000.00),
(5, 5, 6000.00),
(6, 6, 7000.00),
(7, 7, 8000.00),
(8, 8, 9000.00),
(9, 9, 10000.00),
(10, 10, 11000.00);

INSERT INTO film_production_agreements (agreement_type, member_id, contract_id) VALUES
('Acquisition', 1, 1),
('Licensing', 2, 2),
('Acquisition', 3, 3),
('Licensing', 4, 4),
('Acquisition', 5, 5),
('Licensing', 6, 6),
('Acquisition', 7, 7),
('Licensing', 8, 8),
('Acquisition', 9, 9),
('Licensing', 10, 10);

INSERT INTO intellectual_property_agreements (agreement_type, contract_id) VALUES
('Acquisition', 1),
('Licensing', 2),
('Acquisition', 3),
('Licensing', 4),
('Acquisition', 5),
('Licensing', 6),
('Acquisition', 7),
('Licensing', 8),
('Acquisition', 9),
('Licensing', 10);

INSERT INTO distribution_agreements (distribution_type, contract_id) VALUES
('Theatre', 1),
('TV', 2),
('Internet', 3),
('Exhibition', 4),
('Theatre', 5),
('TV', 6),
('Internet', 7),
('Exhibition', 8),
('Theatre', 9),
('TV', 10);

-- restoring original SQL mode settings
SET SESSION sql_mode=@OLD_SQL_MODE;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS, FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;