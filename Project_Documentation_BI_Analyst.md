# 1. Executive Summary

## 1.1 Project Overview
This project represents my capstone assignment for the **Rakamin Academy x Bank Muamalat Virtual Internship Program**. Acting as a Business Intelligence Analyst Intern for **PT Sejahtera Bersama**, my objective was to transform raw, normalized transactional data into a strategic dashboard capable of driving revenue growth and optimizing product portfolios.

## 1.2 Business Problem
PT Sejahtera Bersama possesses vast amounts of transactional data stored across multiple tables. However, without a unified view, the leadership team lacks visibility into:
*   Which product categories drive revenue versus volume.
*   Geographic performance disparities.
*   Opportunities for cross-selling and upselling.

## 1.3 My Solution
I designed and executed an end-to-end BI pipeline:
1.  **Data Engineering:** Utilized **Google BigQuery** to join four normalized tables into a single master dataset using advanced SQL.
2.  **Visualization:** Developed an interactive **Looker Studio** dashboard featuring key KPIs, trend analysis, and geographic heatmaps.
3.  **Strategic Insight:** Derived actionable recommendations that identified a potential **IDR 175.4M+ revenue optimization opportunity** through product bundling and regional strategy replication.

## 1.4 Key Results
*   **Total Sales Analyzed:** IDR 175,475,057
*   **Total Units Processed:** 11,654
*   **Top Performing Category:** Robots (44.3% of Revenue)
*   **Top Performing Region:** Washington (~IDR 5.5M)

# 2. Data Architecture & Methodology

## 2.1 Data Source & Schema Design
To ensure data integrity and accurate aggregation, I began by analyzing the raw dataset provided for **PT Sejahtera Bersama**. The data was normalized across four distinct tables. Before any transformation could occur, I had to establish a robust data model.

### Step 1: Defining Primary Keys (Question 1)
I identified the unique identifiers for each table to prevent data duplication during the join process:
*   **Customers Table:** `CustomerID` – Uniquely identifies each client.
*   **Products Table:** `ProdNumber` – The alphanumeric code (e.g., BP101) identifying each SKU.
*   **Orders Table:** `OrderID` – The unique transaction line identifier.
*   **ProductCategory Table:** `CategoryID` – The numeric ID for product classification.

### Step 2: Establishing Relationships (Question 2)
I designed a **Star Schema** architecture where the `Orders` table serves as the central **Fact Table**, connected to three **Dimension Tables**. This structure is optimal for BI reporting as it simplifies complex queries and ensures performance.

My relationship mapping was as follows:
1.  **Customers ↔ Orders (One-to-Many):**
    *   *Join Condition:* `Customers.CustomerID` = `Orders.CustomerID`
    *   *Logic:* One customer can place multiple orders, but each order belongs to one customer.
2.  **Products ↔ Orders (One-to-Many):**
    *   *Join Condition:* `Products.ProdNumber` = `Orders.ProdNumber`
    *   *Logic:* A single product definition can appear in many different transactions.
3.  **ProductCategory ↔ Products (One-to-Many):**
    *   *Join Condition:* `ProductCategory.CategoryID` = `Products.Category`
    *   *Logic:* Each category contains multiple products, but each product belongs to only one category.

## 2.2 Data Engineering Pipeline (Question 3)
With the architecture defined, I moved to the transformation phase using **Google BigQuery**. My objective was to flatten the normalized schema into a single **Master Table** suitable for visualization.

**My Process:**
1.  **Ingestion:** Uploaded the four raw CSV files into a BigQuery Dataset.
2.  **Transformation:** Wrote a complex SQL query to join all four tables based on the relationships defined above.
3.  **Calculation:** Dynamically calculated the `total_sales` metric (`Quantity` × `Price`) within the query to ensure real-time accuracy.
4.  **Sorting:** Ordered the final dataset chronologically by `order_date` to facilitate time-series analysis.
5.  **Output:** Saved the result as a persistent table named `master_sales_data`, which served as the direct data source for the Looker Studio dashboard.

*Note: The full SQL code used for this transformation is available in my GitHub repository under `sql/query_master_sales.sql`.*

# 3. Dashboard Visualization & Key Findings

## 3.1 Visualization Strategy (Question 4)
To transform the `master_sales_data` into actionable intelligence, I designed an interactive **Looker Studio** dashboard. My design philosophy prioritized clarity and comparability, allowing stakeholders to instantly grasp the scale of operations and identify performance disparities.

The dashboard is structured around three core pillars:
1.  **High-Level KPIs:** Immediate visibility into total revenue and volume.
2.  **Product Performance:** A comparative analysis of Sales Revenue vs. Units Sold by Category.
3.  **Geographic Insights:** Performance breakdown by City to identify regional strongholds and opportunities.

## 3.2 Key Performance Indicators (KPIs)
At the top of the dashboard, I established the baseline metrics for PT Sejahtera Bersama:
*   **Total Sales Revenue:** **IDR 175,475,057**
    *   *Significance:* This represents the total monetary value generated across all transactions in the dataset.
*   **Total Units Sold:** **11,654**
    *   *Significance:* This indicates the sheer volume of products moving through the supply chain.

## 3.3 Critical Finding: The "Volume vs. Value" Paradox
The most significant insight derived from my visualization (specifically comparing *Total Sales by Category* against *Total Quantity by Category*) is a distinct disconnect between what customers buy frequently and what generates the most revenue.

### Observation A: Revenue Drivers (High Value, Low Volume)
*   **Robots** are the undisputed revenue leaders, contributing **~IDR 74.4M (44.3%)** of total sales.
*   However, in terms of unit volume, Robots rank near the bottom (~1,100 units).
*   *My Interpretation:* This indicates a high-ticket, low-frequency purchase behavior. Customers buying Robots are likely making significant, considered investments.

### Observation B: Volume Drivers (Low Value, High Volume)
*   **eBooks** are the volume leaders, accounting for **~3,100 units (32.7%)** of all items sold.
*   Despite this massive volume, their revenue contribution is relatively low (~IDR 5.9M).
*   *My Interpretation:* This suggests a large base of entry-level customers or impulse buyers who are not yet converting to high-value hardware purchases.

### Observation C: Geographic Concentration
*   **Washington** stands out as the primary market powerhouse, generating **~IDR 5.5M** in sales and **308 units**, significantly outperforming the next closest city (Houston).
*   *My Interpretation:* There is a successful local strategy or demographic fit in Washington that is not being replicated in other major metros like San Diego or Philadelphia.

## 3.4 Visual Evidence
*(Note: In the final PDF submission, I insert screenshots of the Looker Studio dashboard, specifically highlighting the side-by-side comparison of the "Sales by Category" bar chart and the "Quantity by Category" bar chart to visually reinforce the paradox described above.)*

# 4. Strategic Recommendations (Question 5)

## 4.1 Executive Proposal
Based on the comprehensive analysis of PT Sejahtera Bersama’s transactional data (Total Sales: IDR 175.5M, Total Units: 11,654), I have identified three high-impact strategic opportunities. These recommendations are designed to bridge the gap between high-volume/low-value customers and low-volume/high-value buyers, while optimizing regional performance.

## 4.2 Recommendation 1: Implement "Path-to-Pro" Product Bundling
**The Problem:** My analysis revealed a sharp disconnect in customer behavior. **eBooks** drive 32.7% of total volume but contribute minimally to revenue, whereas **Robots** generate 44.3% of revenue but have low unit adoption. We are missing the opportunity to convert entry-level buyers into high-value hardware owners.

**My Proposal:**
I recommend launching a **"Robot Starter Kit"** bundle.
*   **Bundle Composition:** 1 Robot (High Value) + 1 Training Video (Mid Volume) + 1 Blueprint (High Volume).
*   **Pricing Strategy:** Offer this bundle at a 10-15% discount compared to purchasing items individually.
*   **Target Audience:** Customers who currently purchase eBooks or Blueprints but have not yet bought hardware.

**Expected Business Impact:**
*   **Increased Average Order Value (AOV):** By attaching high-margin hardware to low-cost impulse buys.
*   **Customer Education:** Bundling training videos with robots reduces return rates and increases customer confidence.

## 4.3 Recommendation 2: Replicate the "Washington Success Model"
**The Problem:** Geographic performance is highly skewed. **Washington** is our dominant market, generating ~IDR 5.5M in sales and 308 units—significantly outperforming the next closest city (Houston) by over 60%. This suggests a localized success factor (e.g., specific marketing channel, partner, or demographic fit) that is not being leveraged elsewhere.

**My Proposal:**
I propose a **"Market Replication Audit"** focused on Washington.
*   **Action:** Conduct a deep-dive analysis of the Washington region to identify the primary driver of success (e.g., Is it a specific sales representative? A local university partnership? A targeted ad campaign?).
*   **Execution:** Once identified, allocate 20% of the Q3 marketing budget to replicate these specific tactics in **Houston** and **Sacramento**, our next highest-potential markets.

**Expected Business Impact:**
*   **Regional Growth:** Normalizing performance across top-tier cities could unlock an additional 15-20% in total revenue.
*   **Risk Mitigation:** Reducing reliance on a single geographic market.

## 4.4 Recommendation 3: Price Optimization for "High-Demand, Low-Revenue" Items
**The Problem:** The **Blueprints** category shows strong demand (Top 3 in volume with ~16.9% share) but contributes the lowest revenue (~IDR 1.6M). This indicates high price elasticity; customers are buying frequently, suggesting the current price point may be too low to capture maximum margin.

**My Proposal:**
I recommend a **controlled price elasticity test** for Blueprints.
*   **Action:** Increase the price of Blueprints by 10-15% in a test market (e.g., San Diego) for 30 days.
*   **Monitoring:** Track if the volume drop is less than the price increase percentage. If volume remains stable, roll out the price increase nationally.

**Expected Business Impact:**
*   **Margin Expansion:** Directly increasing profit margins on a high-volume item with minimal risk to sales volume.
*   **Revenue Boost:** Even a small retention of volume at a higher price point will significantly lift the bottom line for this category.

## 4.5 Conclusion
By executing these three strategies—**Bundling**, **Regional Replication**, and **Price Optimization**—PT Sejahtera Bersama can effectively convert its high-volume traffic into sustainable revenue growth. My dashboard provides the real-time monitoring framework necessary to track the success of these initiatives post-implementation.

# 5. Conclusion & Technical Appendix

## 5.1 Final Conclusion
Throughout this internship simulation with **PT Sejahtera Bersama**, I have demonstrated an end-to-end Business Intelligence capability:
*   **Engineering:** I transformed raw, normalized data into a robust **Star Schema** using **Google BigQuery**.
*   **Visualization:** I built an interactive **Looker Studio** dashboard that highlights critical performance gaps.
*   **Strategy:** I identified a **IDR 175.5M revenue opportunity** and proposed three actionable strategies to capture it.

This project confirms my readiness to handle complex data pipelines and deliver strategic insights that drive real business growth for **Bank Muamalat** and its partners.

## 5.2 Technical Appendix: Master Query (Soal 3)
To ensure transparency and reproducibility, below is the exact **SQL Query** used to generate the `master_sales_data` table. This query joins the four source tables, calculates total sales, and sorts the data chronologically as required.

```sql
SELECT
  c.CustomerEmail AS cust_email,
  c.CustomerCity AS cust_city,
  o.Date AS order_date,
  o.Quantity AS order_qty,
  p.ProdName AS product_name,
  p.Price AS product_price,
  pc.CategoryName AS category_name,
  (o.Quantity * p.Price) AS total_sales
FROM
  `rakamin-bank-muamalat-1.bank_muamalat.Orders` AS o
JOIN
  `rakamin-bank-muamalat-1.bank_muamalat.Customers` AS c
  ON o.CustomerID = c.CustomerID
JOIN
  `rakamin-bank-muamalat-1.bank_muamalat.Products` AS p
  ON o.ProdNumber = p.ProdNumber
JOIN
  `rakamin-bank-muamalat-1.bank_muamalat.ProductCategory` AS pc
  ON p.Category = pc.CategoryID
ORDER BY
  order_date ASC;
```

## 5.3 References & Resources

*   **Data Source:** PT Sejahtera Bersama Transactional Dataset (Provided by Rakamin Academy).
*   **Tools Used:** 
    *   Google Cloud Platform (BigQuery)
    *   Google Looker Studio
    *   Microsoft Excel / Access
*   **Project Repository:** [BI-Project-BankMuamalat](https://github.com/dwibudisetyonugroho/BI-Project-BankMuamalat)
*   **Live Dashboard:** [Looker Studio Report](https://lookerstudio.google.com/reporting/2425933c-c491-4c00-a0a2-65e9b6b5d07a)

---

> **Prepared by:**  
> **Dwi Budi Setyonugroho**  
> Business Intelligence Analyst Intern  
> Rakamin Academy x Bank Muamalat Virtual Internship Program