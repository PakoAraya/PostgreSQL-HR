# HR-DB: Oracle Human Resources Schema for PostgreSQL 16.1

### Ported & Enhanced by **PaKo Araya**
🔗 LinkedIn: https://www.linkedin.com/in/franarayah/


![GitHub](https://img.shields.io/badge/GitHub-PaKoAraya-0D1117?style=for-the-badge&logo=github&logoColor=white) ![GitLab](https://img.shields.io/badge/GitLab-PaKoAraya-6B4EFF?style=for-the-badge&logo=gitlab&logoColor=FC6D26)

<img src="database/docs/images/Banner.png" alt="HR-DB Banner" width="100%">

# 🐘 PostgreSQL HR Database
## Database Schema Preview
![Database Schema Preview](database/docs/images/Schema.png)

## General Information
[![PostgreSQL Version](https://img.shields.io/badge/PostgreSQL-16.1-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://github.com/PakoAraya/PostgreSQL-HR/blob/main/LICENSE)
[![GitLab Mirroring](https://img.shields.io/badge/GitLab_Mirroring-GitLab_to_GitHub-blue?style=for-the-badge&logo=gitlab)](https://github.com/PakoAraya/PostgreSQL-HR)
[![Compatibility](https://img.shields.io/badge/Compatibility-Oracle_➡️_PostgreSQL-success?style=for-the-badge&logo=oracle&logoColor=white)](https://www.postgresql.org/)

This project is a modern and optimized recreation of the classic **Human Resources (HR)** Schema from Oracle Database. It is initially adapted for **PostgreSQL 16.1**, with a few minor changes to support the latest version currently in development.

---

## ✨ Key Features

- 🏛️ **Classic Structure:** Includes all 7 original tables (`EMPLOYEES`, `DEPARTMENTS`, `JOBS`, ETC.).
- 🛠️ **PostgreSQL Optimized:** Adjusted data types (e.g., `SERIAL`, `TINYINT` for regions).
- ⚙️ **Business Logic:** Dedicated scripts for Stored Procedures, Triggers and Functions.
- 💽 **Sample Data:** Full dataset population for immediate testing and querying.
- 🎛️ **Automation:** Automated mirroring configured from GitLab to GitHub via SSH.

---


## 🚀 Quick Start (PostgreSQL 16.1)

```bash
# 1. Clone the repository
# Choose one:
git clone [https://gitlab.com/PaKoAraya/postgresql-hr.git](https://gitlab.com/PaKoAraya/postgresql-hr.git)
# or
git clone [https://github.com/PaKoAraya/PostgreSQL-HR.git](https://github.com/PaKoAraya/PostgreSQL-HR.git)

# 2. Navigate to the project directory
cd postgresql-hr/database

# 3. Import the schema and sample data
# Replace 'your_user' and 'your_db' with your actual PostgreSQL credentials
psql -U your_user -d your_db -f ../schema/tables/hr_tables.sql
psql -U your_user -d your_db -f ../data/hr_data_seed.sql
```

---

## 🛠️ Tech Stack
| Component | Tool |
| :--- | :--- |
| **Database Engine** | [![PostgreSQL Version](https://img.shields.io/badge/PostgreSQL-16.1-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)|
| **Language** | [![SQL](https://img.shields.io/badge/SQL-PL%2FpgSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/docs/current/plpgsql.html) [![Standard](https://img.shields.io/badge/Standard-ANSI_SQL-orange?style=for-the-badge)](https://en.wikipedia.org/wiki/SQL) |
| **Repo Work Strategy** _(Mirroring)_ | [![GitLab](https://img.shields.io/badge/GitLab-FC6D26?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/PaKoAraya/postgresql-hr) ⬅️➡️ [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/PakoAraya/PostgreSQL-HR) |
| **Version Release** | [![GitLab Release](https://img.shields.io/gitlab/v/release/PaKoAraya/postgresql-hr?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/PaKoAraya/postgresql-hr/-/releases)  [![GitHub Release](https://img.shields.io/github/v/release/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white)](https://github.com/PakoAraya/PostgreSQL-HR/releases) |
| **Last Commit** | [![GitLab Last Commit](https://img.shields.io/gitlab/last-commit/PaKoAraya/postgresql-hr?style=for-the-badge&logo=gitlab&logoColor=white)](https://gitlab.com/PaKoAraya/postgresql-hr/-/commits/main)  [![GitHub Last Commit](https://img.shields.io/github/last-commit/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white)](https://github.com/PakoAraya/PostgreSQL-HR/commits/main) |

--- 

## 📂 Project Structure
```bash
hr-db
├── database
│   ├── data
│   │   ├── hr_data_seed.sql        # Sample data and population scripts (Inserts)
│   │   └── hr_queries.sql          # SQL test queries and reports (Selects)
│   ├── docs
│   │   ├── images
│   │   │   ├── Banner.png          # Project banner
│   │   │   └── Schema.png          # Database schema diagram
│   │   └── documentation           # Project documentation
│   ├── functions
│   │   └── hr_functions.sql        # Stored Functions
│   ├── migrations
│   │   └── v1_initial_hr.sql       # Database migration scripts
│   ├── procedures
│   │   └── hr_procedures.sql       # Stored Procedures
│   ├── schema
│   │   ├── indexes
│   │   │   └── hr_indexes.sql      # Indexes
│   │   ├── tables
│   │   │   └── hr_tables.sql       # Tables
│   │   ├── views
│   │   │   └── hr_views.sql        # Views
│   │   └── triggers
│   │       └── hr_triggers.sql     # Triggers
│   └── README.md                   # Project documentation
├── LICENSE                         # Project license
├── README.md                       # Project documentation
├── .gitignore                      # Git ignore file
```

---

## 🗺️ Schema Entities 
The project recreates the full organizational hierarchy:

1.- **REGIONS & COUNTRIES:** Geographical regions and countries structure.
2.- **LOCATIONS & DEPARTMENTS:** Physical sites and business units.
3.- **JOBS & JOB_HISTORY:** Salary definitions and role transitions.
4.- **EMPLOYEES:** Master data, salary management and reporting lines.

---

## 📊 Repository Statistics

| Metric | Values |
| :--- | :--- |
| **Last Commit** | [![GitLab](https://img.shields.io/gitlab/last-commit/PaKoAraya/postgresql-hr?style=for-the-badge&logo=gitlab&logoColor=white&color=FC6D26&label=GitLab)](https://gitlab.com/PaKoAraya/postgresql-hr/-/commits/main) [![GitHub](https://img.shields.io/github/last-commit/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717&label=GitHub)](https://github.com/PakoAraya/PostgreSQL-HR/commits/main) |
| **Total Commits** | [![GitLab Commits](https://img.shields.io/github/commit-activity/t/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=gitlab&logoColor=white&color=FC6D26&label=GitLab)](https://gitlab.com/PaKoAraya/postgresql-hr/-/commits/main) [![GitHub](https://img.shields.io/github/commit-activity/t/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717&label=GitHub)](https://github.com/PakoAraya/PostgreSQL-HR/commits/main) |
| **Commit Activity** | [![Year](https://img.shields.io/github/commit-activity/y/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717&label=Year)](https://github.com/PakoAraya/PostgreSQL-HR/commits/main) [![Month](https://img.shields.io/github/commit-activity/m/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717&label=Month)](https://github.com/PakoAraya/PostgreSQL-HR/commits/main) |
| **Repo Size** | [![Size](https://img.shields.io/github/repo-size/PaKoAraya/PostgreSQL-HR?style=for-the-badge&color=blue&label=Size)](https://github.com/PakoAraya/PostgreSQL-HR) [![Languages](https://img.shields.io/github/languages/count/PaKoAraya/PostgreSQL-HR?style=for-the-badge&color=blue&label=Languages)](https://github.com/PakoAraya/PostgreSQL-HR) |
| **Project Issues** | [![GitLab](https://img.shields.io/gitlab/issues/open/PaKoAraya/postgresql-hr?style=for-the-badge&logo=gitlab&logoColor=white&color=FC6D26&label=GitLab)](https://gitlab.com/PaKoAraya/postgresql-hr/-/issues) [![GitHub](https://img.shields.io/github/issues/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717&label=GitHub)](https://github.com/PakoAraya/PostgreSQL-HR/issues) |
| **Merge/Pull Requests** | [![GitLab](https://img.shields.io/gitlab/merge-requests/open/PaKoAraya/postgresql-hr?style=for-the-badge&logo=gitlab&logoColor=white&color=FC6D26&label=GitLab%20MRs)](https://gitlab.com/PaKoAraya/postgresql-hr/-/merge_requests) [![GitHub](https://img.shields.io/github/issues-pr/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717&label=GitHub%20PRs)](https://github.com/PakoAraya/PostgreSQL-HR/pulls) |
| **Stars & Forks** | [![Stars](https://img.shields.io/github/stars/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717)](https://github.com/PakoAraya/PostgreSQL-HR/stargazers) [![Forks](https://img.shields.io/github/forks/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717)](https://github.com/PakoAraya/PostgreSQL-HR/network/members) |
| **Contributors** | [![Contributors](https://img.shields.io/github/contributors/PaKoAraya/PostgreSQL-HR?style=for-the-badge&logo=github&logoColor=white&color=181717)](https://github.com/PakoAraya/PostgreSQL-HR/graphs/contributors) |
| **Database Logic** | [![SQL Scripts](https://img.shields.io/badge/SQL_Scripts-10_Files-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://github.com/PakoAraya/PostgreSQL-HR/tree/main/database) |
| **License** | [![License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://github.com/PakoAraya/PostgreSQL-HR/blob/main/LICENSE) |

---

## 🪪 License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

--- 

## 📝 Acknowledgements
* 🙏 Special thanks to [Oracle](https://www.oracle.com/) for providing the original HR schema.
* 🙏 Special thanks to [PostgreSQL](https://www.postgresql.org/) for providing the open-source database.
* 🙏 Special thanks to [GitLab](https://gitlab.com/) for providing the Git repository hosting and mirroring service.

---

## 📝 Contact
If you have any questions or suggestions, please feel free to contact me at [franarayah@gmail.com](mailto:franarayah@gmail.com).

