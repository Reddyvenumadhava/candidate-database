# Candidate Database Deployment

## Environments

* Dev: candidate
* QA: candidate_qa

## Steps to Deploy

1. Select database:

   ```sql
   USE candidate;      -- for Dev
   USE candidate_qa;   -- for QA
   ```

2. Run schema script:

   ```sql
   SOURCE schema.sql;
   ```

## CI/CD Concept

* Code is stored in GitHub
* Any changes to schema.sql can be deployed to QA/Production
* No manual database creation required

## Author

Your Name
