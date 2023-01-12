/*
CoderPad provides a basic SQL sandbox with the following schema.
You can also use commands like `show tables` and `desc employees`

employees                             projects
+---------------+---------+           +---------------+---------+
| id            | int     |<----+  +->| id            | int     |
| first_name    | varchar |     |  |  | title         | varchar |
| last_name     | varchar |     |  |  | start_date    | date    |
| salary        | int     |     |  |  | end_date      | date    |
| department_id | int     |--+  |  |  | budget        | int     |
+---------------+---------+  |  |  |  +---------------+---------+
                             |  |  |
departments                  |  |  |  employees_projects
+---------------+---------+  |  |  |  +---------------+---------+
| id            | int     |<-+  |  +--| project_id    | int     |
| name          | varchar |     +-----| employee_id   | int     |
+---------------+---------+           +---------------+---------+
*/

--------------
SELECT e.first_name, e.last_name, e.salary,
  d.name as department_name
FROM employees   AS e
JOIN departments AS d ON e.department_id = d.id
--------------

+------------+-----------+--------+-----------------+
| first_name | last_name | salary | department_name |
+------------+-----------+--------+-----------------+
| John       | Smith     |  20000 | Reporting       |
| Ava        | Muffinson |  10000 | Silly Walks     |
| Cailin     | Ninson    |  30000 | Engineering     |
| Mike       | Peterson  |  20000 | Engineering     |
| Ian        | Peterson  |  80000 | Engineering     |
| John       | Mills     |  50000 | Marketing       |
+------------+-----------+--------+-----------------+

DESCRIBE departments;
+-------+--------------+------+-----+---------+----------------+
| Field | Type         | Null | Key | Default | Extra          |
+-------+--------------+------+-----+---------+----------------+
| id    | int          | NO   | PRI | NULL    | auto_increment |
| name  | varchar(255) | YES  |     | NULL    |                |
+-------+--------------+------+-----+---------+----------------+

DESCRIBE employee_projects;
+--------------+------+------+---------+---------+-------+
| Field        | Type | Null | Key     | Default | Extra |
+--------------+------+------+---------+---------+-------+
| project_id   | int  | YES  | MUL     | NULL    |       |
| employee_id  | int  | YES  | MUL     | NULL    |       |
+--------------+------+------+---------+---------+-------+

DESCRIBE employees;
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| id            | int          | NO   | PRI | NULL    | auto_increment |
| first_name    | varchar(255) | YES  |     | NULL    |                |
| last_name     | varchar(255) | YES  |     | NULL    |                |
| salary        | int          | YES  |     | NULL    |                |
| department_id | int          | YES  | MUL | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+

DESCRIBE projects;
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int          | NO   | PRI | NULL    | auto_increment |
| title      | varchar(255) | YES  |     | NULL    |                |
| start_date | date         | YES  |     | NULL    |                |
| end_date   | date         | YES  |     | NULL    |                |
| budget     | int          | YES  |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+

# constraints lookup on join table to identify relations
select distinct CONSTRAINT_NAME
from information_schema.TABLE_CONSTRAINTS
where table_name = 'employee_projects' and constraint_type = 'UNIQUE'

# ==== rails models + relations
class Department < ApplicationRecord
  has_many :employees
end

class Employee < ApplicationRecord
  belongs_to :department, optional: true

  # retrieve all employees in a department given department_id
  scope :by_department, ->(department) { where(department: department) }

  # all Projects employee is assigned to given employee_id
  #----
  # many to many (many employees can have many shared projects)
  has_and_belongs_to_many :projects, join_table: 'employee_projects'
  #----
  # one to many as table name implies
  # has_many :employee_projects
  # alias :projects :employee_projects
end

# class EmployeeProject < ApplicationRecord
#   belongs_to :employee, optional: true
#   belongs_to :project, optional: true
# end

class Project < ApplicationRecord
  # many to many
  has_and_belongs_to_many :employees, join_table: 'employee_projects'

  # many to one (many employees can have multiple projects)
  # has_one :employee_project
  # has_one :employee, through: :employee_project
end

# migrations
class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    create_table :departments
    execute(%Q{
      ALTER TABLE `departments`
        ADD COLUMN `name` varchar(255) NULL
    })
  end
end

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    create_table :employees do |t|
      t.references :department
    end
    execute(%Q{
      ALTER TABLE `employees`
        ADD COLUMN `first_name` varchar(255) NULL,
        ADD COLUMN `last_name` varchar(255) NULL,
        ADD COLUMN `salary` int NULL
    })
  end
end

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    create_table :projects
    execute(%Q{
      ALTER TABLE `projects`
        ADD COLUMN `title` varchar(255) NULL,
        ADD COLUMN `start_date` date NULL,
        ADD COLUMN `end_date` date NULL,
        ADD COLUMN `budget` int NULL
    })
  end
end

class CreateEmployeeProjects < ActiveRecord::Migration[5.2]
  def change
    return if Rails.env.production?
    create_table :employee_projects, id: false do |t|
      t.references :project
      t.references :employee
    end
  end
end
