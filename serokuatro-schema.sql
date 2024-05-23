-- setting the charset
SET NAMES utf8mb4;

-- saving original SQL mode settings
SET @OLD_SQL_MODE=@@SQL_MODE;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS;

-- setting desired SQL mode
SET SESSION sql_mode='STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET UNIQUE_CHECKS=0, FOREIGN_KEY_CHECKS=0;

-- creating database if not exists
DROP DATABASE IF EXISTS serokuatro_prod;
CREATE DATABASE serokuatro_prod;
USE serokuatro_prod;

--
-- TABLE CREATION
--

CREATE TABLE IF NOT EXISTS members (
    member_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    pronouns VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role_id INT UNSIGNED NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    studio_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_member_role_id FOREIGN KEY (role_id) REFERENCES roles (role_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_member_department_id FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_member_studio_id FOREIGN KEY (studio_id) REFERENCES studios (studio_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS roles (
    role_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    department_id INT UNSIGNED NOT NULL,
    CONSTRAINT fk_role_department_id FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS departments (
    department_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_head_id INT UNSIGNED,
    CONSTRAINT fk_department_head_id FOREIGN KEY (department_head_id) REFERENCES members (member_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS studios (
    studio_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    studio_name VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20),
    studio_email VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    facilities TEXT,
    capacity INT UNSIGNED,
    available BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS projects (
    project_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    type ENUM('Film', 'TV Show', 'Music Video') NOT NULL,
    release_date DATE,
    studio_id INT UNSIGNED NOT NULL,
    scale ENUM('Small', 'Medium', 'Large'),
    stage ENUM('Development', 'Pre-production', 'Production', 'Post-production', 'Distribution'),
    CONSTRAINT fk_project_studio_id FOREIGN KEY (studio_id) REFERENCES studios (studio_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS distribution_channels (
    channel_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL,
    channel_type ENUM('Theatrical', 'Streaming', 'Television', 'Home Video') NOT NULL,
    exclusive_licensing BOOLEAN NOT NULL,
    fee_type ENUM('FA', 'PER') NOT NULL,
    contact_name VARCHAR(100),
    contact_phone VARCHAR(15),
    contact_email VARCHAR(100),
    region VARCHAR(100),
    licensing_details TEXT,
    website VARCHAR(255),
    notes TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS project_members (
    project_id INT UNSIGNED NOT NULL,
    member_id INT UNSIGNED NOT NULL,
    role_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (project_id, member_id),
    CONSTRAINT fk_pm_project_id FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pm_member_id FOREIGN KEY (member_id) REFERENCES members (member_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pm_role_id FOREIGN KEY (role_id) REFERENCES roles (role_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS project_distribution_channels (
    project_id INT UNSIGNED NOT NULL,
    channel_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (project_id, channel_id),
    CONSTRAINT fk_pdc_project_id FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pdc_channel_id FOREIGN KEY (channel_id) REFERENCES distribution_channels (channel_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS contracts (
    contract_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    contract_type ENUM('FPA', 'IPA', 'DA') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    terms TEXT,
    project_id INT UNSIGNED,
    member_id INT UNSIGNED,
    CONSTRAINT fk_contract_project_id FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_contract_member_id FOREIGN KEY (member_id) REFERENCES members (member_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS film_production_agreements (
    fpa_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    contract_id INT UNSIGNED NOT NULL,
    agreement_type ENUM('Acquisition', 'Licensing') NOT NULL,
    member_id INT UNSIGNED,
    CONSTRAINT fk_fpa_contract_id FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_fpa_member_id FOREIGN KEY (member_id) REFERENCES members (member_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS intellectual_property_agreements (
    ipa_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    contract_id INT UNSIGNED NOT NULL,
    agreement_type ENUM('Acquisition', 'Licensing') NOT NULL,
    CONSTRAINT fk_ipa_contract_id FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS distribution_agreements (
    da_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    contract_id INT UNSIGNED NOT NULL,
    distribution_type ENUM('Theatre', 'TV', 'Internet', 'Exhibition') NOT NULL,
    CONSTRAINT fk_da_contract_id FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS financial_transactions (
    transaction_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    transaction_date DATE NOT NULL,
    transaction_type ENUM('Income', 'Expense') NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    description TEXT,
    project_id INT UNSIGNED,
    CONSTRAINT fk_transaction_project_id FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS member_payroll (
    payroll_id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    member_id INT UNSIGNED NOT NULL,
    transaction_id INT UNSIGNED NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    CONSTRAINT fk_payroll_member_id FOREIGN KEY (member_id) REFERENCES members (member_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_transaction_id FOREIGN KEY (transaction_id) REFERENCES financial_transactions (transaction_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- VIEW CREATION
--

CREATE VIEW project_details AS
SELECT 
    p.project_id,
    p.title,
    p.description,
    p.type,
    p.release_date,
    s.studio_name,
    s.contact_phone,
    s.studio_email,
    p.scale,
    p.stage,
    CONCAT(m.first_name, ' ', m.last_name) AS department_head,
    GROUP_CONCAT(DISTINCT CONCAT(m2.first_name, ' ', m2.last_name) SEPARATOR ', ') AS team_members,
    GROUP_CONCAT(DISTINCT dc.channel_name ORDER BY dc.channel_name SEPARATOR ', ') AS distribution_channels,
    GROUP_CONCAT(DISTINCT fpa.agreement_type ORDER BY fpa.agreement_type SEPARATOR ', ') AS film_production_agreements,
    GROUP_CONCAT(DISTINCT ipa.agreement_type ORDER BY ipa.agreement_type SEPARATOR ', ') AS intellectual_property_agreements,
    GROUP_CONCAT(DISTINCT da.distribution_type ORDER BY da.distribution_type SEPARATOR ', ') AS distribution_agreements
FROM projects p
JOIN studios s ON p.studio_id = s.studio_id
LEFT JOIN project_members pm ON p.project_id = pm.project_id
LEFT JOIN members m ON m.member_id = pm.member_id AND m.role_id IS NULL
LEFT JOIN members m2 ON m2.member_id = pm.member_id
LEFT JOIN project_distribution_channels pdc ON p.project_id = pdc.project_id
LEFT JOIN distribution_channels dc ON pdc.channel_id = dc.channel_id
LEFT JOIN contracts c ON p.project_id = c.project_id
LEFT JOIN film_production_agreements fpa ON c.contract_id = fpa.contract_id
LEFT JOIN intellectual_property_agreements ipa ON c.contract_id = ipa.contract_id
LEFT JOIN distribution_agreements da ON c.contract_id = da.contract_id
GROUP BY p.project_id;

CREATE VIEW member_roles AS
SELECT 
    m.first_name,
    m.last_name,
    r.role_name,
    p.title AS project_title,
    p.description AS project_description,
    p.release_date AS project_release_date,
    CONCAT(s.studio_name, ', ', s.city, ', ', s.country) AS studio_location,
    COUNT(DISTINCT pm.project_id) AS projects_assigned,
    GROUP_CONCAT(DISTINCT p.type SEPARATOR ', ') AS project_types
FROM members m
JOIN project_members pm ON m.member_id = pm.member_id
JOIN roles r ON pm.role_id = r.role_id
JOIN projects p ON pm.project_id = p.project_id
JOIN studios s ON p.studio_id = s.studio_id
GROUP BY m.member_id, m.first_name, m.last_name, r.role_name, s.studio_name, s.city, s.country;

CREATE VIEW financial_summary AS
SELECT 
    p.project_id,
    p.title AS project_title,
    p.description,
    p.release_date,
    s.studio_name,
    SUM(COALESCE(ft.amount, 0)) AS total_income,
    SUM(CASE WHEN ft.transaction_type = 'Expense' THEN ft.amount ELSE 0 END) AS total_expenses,
    SUM(COALESCE(ft.amount, 0)) - SUM(CASE WHEN ft.transaction_type = 'Expense' THEN ft.amount ELSE 0 END) AS net_profit
FROM projects p
INNER JOIN studios s ON p.studio_id = s.studio_id
LEFT JOIN financial_transactions ft ON p.project_id = ft.project_id
GROUP BY p.project_id, p.title, p.description, p.release_date, s.studio_name;

CREATE VIEW studio_capacity AS
SELECT 
    s.studio_id,
    s.studio_name,
    s.capacity AS max_capacity,
    COUNT(p.project_id) AS current_projects_count
FROM studios s
LEFT JOIN projects p ON s.studio_id = p.studio_id
GROUP BY s.studio_id, s.studio_name, s.capacity;

CREATE VIEW project_contract_details AS
SELECT 
    p.project_id,
    p.title AS project_title,
    c.contract_id,
    c.contract_type,
    c.start_date AS contract_start_date,
    c.end_date AS contract_end_date,
    c.terms AS contract_terms,
    CASE 
        WHEN c.contract_type = 'FPA' THEN fpa.agreement_type
        WHEN c.contract_type = 'IPA' THEN ipa.agreement_type
        WHEN c.contract_type = 'DA' THEN da.distribution_type
        ELSE NULL
    END AS agreement_type,
    m.member_id,
    CONCAT(m.first_name, ' ', m.last_name) AS member_name
FROM 
    projects p
LEFT JOIN 
    contracts c ON p.project_id = c.project_id
LEFT JOIN 
    film_production_agreements fpa ON c.contract_id = fpa.contract_id
LEFT JOIN 
    intellectual_property_agreements ipa ON c.contract_id = ipa.contract_id
LEFT JOIN 
    distribution_agreements da ON c.contract_id = da.contract_id
LEFT JOIN 
    members m ON c.member_id = m.member_id OR fpa.member_id = m.member_id;

--
-- FUNCTION CREATION
--

DELIMITER //
CREATE FUNCTION calculate_project_budget(proj_id INT UNSIGNED) RETURNS DECIMAL(15, 2)
READS SQL DATA
BEGIN
    DECLARE total_expenses DECIMAL(15, 2);
    SELECT SUM(amount) INTO total_expenses 
    FROM financial_transactions 
    WHERE project_id = proj_id AND transaction_type = 'Expense';
    RETURN total_expenses;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION count_projects_by_type(project_type ENUM('Film', 'TV Show', 'Music Video')) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(*) INTO project_count FROM projects WHERE type = project_type;
    RETURN project_count;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION get_member_role(p_member_id INT UNSIGNED, p_project_id INT UNSIGNED) RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE role_name VARCHAR(100);
    SELECT r.role_name INTO role_name 
    FROM roles r
    JOIN project_members pm ON r.role_id = pm.role_id
    WHERE pm.member_id = p_member_id AND pm.project_id = p_project_id;
    RETURN role_name;
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION check_studio_availability(input_studio_id INT UNSIGNED) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE studio_capacity INT;
    DECLARE projects_count INT;
    SELECT s.capacity, COUNT(p.project_id)
    INTO studio_capacity, projects_count
    FROM studios s
    LEFT JOIN projects p ON s.studio_id = p.studio_id
    WHERE s.studio_id = input_studio_id
    GROUP BY s.studio_id;
    RETURN studio_capacity > projects_count;
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION get_total_income(proj_id INT UNSIGNED) RETURNS DECIMAL(15, 2)
READS SQL DATA
BEGIN
    DECLARE total_income DECIMAL(15, 2);
    SELECT SUM(amount) INTO total_income 
    FROM financial_transactions 
    WHERE project_id = proj_id AND transaction_type = 'Income';
    RETURN total_income;
END //
DELIMITER ;

--
-- STORED PROCEDURE CREATION
--

DELIMITER //
CREATE PROCEDURE assign_member_to_project (
    IN p_project_id INT UNSIGNED,
    IN p_member_id INT UNSIGNED,
    IN p_role_id INT UNSIGNED
)
BEGIN
    INSERT INTO project_members (project_id, member_id, role_id)
    VALUES (p_project_id, p_member_id, p_role_id);
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE update_project_stage (
    IN p_project_id INT UNSIGNED,
    IN p_new_stage ENUM('Development', 'Pre-production', 'Production', 'Post-production', 'Distribution')
)
BEGIN
    UPDATE projects
    SET stage = p_new_stage
    WHERE project_id = p_project_id;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE calculate_member_total_payroll(
    IN p_member_id INT UNSIGNED,
    OUT total_payroll DECIMAL(15, 2)
)
BEGIN
    SELECT SUM(amount)
    INTO total_payroll
    FROM member_payroll
    WHERE member_id = p_member_id;
END //
DELIMITER ;

-- restoring original SQL mode settings
SET SESSION sql_mode=@OLD_SQL_MODE;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS, FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;