-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 01, 2026 at 01:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmacore`
--

-- --------------------------------------------------------

--
-- Table structure for table `applied_migrations`
--

CREATE TABLE `applied_migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `migration_version` varchar(64) NOT NULL,
  `migration_file` varchar(255) NOT NULL,
  `checksum` char(64) NOT NULL,
  `applied_at` datetime NOT NULL,
  `applied_by` varchar(190) DEFAULT NULL,
  `success` tinyint(1) NOT NULL DEFAULT 1,
  `error_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(190) NOT NULL,
  `record_id` bigint(20) UNSIGNED DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `backup_jobs`
--

CREATE TABLE `backup_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `schedule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `trigger_source` varchar(20) NOT NULL DEFAULT 'MANUAL',
  `custom_label` varchar(120) DEFAULT NULL,
  `backup_type` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'RUNNING',
  `original_filename` varchar(255) DEFAULT NULL,
  `stored_path` varchar(255) DEFAULT NULL,
  `storage_root_path` varchar(500) DEFAULT NULL,
  `file_size_bytes` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `checksum` char(64) NOT NULL,
  `file_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `database_name` varchar(190) DEFAULT NULL,
  `migration_version` varchar(64) DEFAULT NULL,
  `manifest_json` mediumtext DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_at` datetime DEFAULT NULL,
  `restored_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `backup_restores`
--

CREATE TABLE `backup_restores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `backup_job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `mode` varchar(20) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'RUNNING',
  `source_filename` varchar(255) DEFAULT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `started_at` datetime NOT NULL DEFAULT current_timestamp(),
  `completed_at` datetime DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `backup_schedules`
--

CREATE TABLE `backup_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `frequency` varchar(20) NOT NULL DEFAULT 'DAILY',
  `run_time` time NOT NULL DEFAULT '02:00:00',
  `start_date` date NOT NULL,
  `day_of_week` tinyint(3) UNSIGNED DEFAULT NULL,
  `day_of_month` tinyint(3) UNSIGNED DEFAULT NULL,
  `timezone` varchar(64) NOT NULL DEFAULT 'Asia/Kabul',
  `backup_type` varchar(20) NOT NULL DEFAULT 'DATABASE',
  `destination_subdir` varchar(255) DEFAULT NULL,
  `destination_path` varchar(500) DEFAULT NULL,
  `retention_count` int(10) UNSIGNED NOT NULL DEFAULT 30,
  `next_run_at` datetime DEFAULT NULL,
  `last_run_at` datetime DEFAULT NULL,
  `last_status` varchar(20) DEFAULT NULL,
  `last_error` varchar(1000) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `updated_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `backup_schedule_runs`
--

CREATE TABLE `backup_schedule_runs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `schedule_id` bigint(20) UNSIGNED NOT NULL,
  `backup_job_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `error_message` varchar(1000) DEFAULT NULL,
  `started_at` datetime NOT NULL DEFAULT current_timestamp(),
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bins`
--

CREATE TABLE `bins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(190) NOT NULL,
  `code` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `timezone` varchar(64) NOT NULL DEFAULT 'Asia/Kabul',
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cashier_shifts`
--

CREATE TABLE `cashier_shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `opened_by` bigint(20) UNSIGNED NOT NULL,
  `opened_at` datetime NOT NULL,
  `closed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'OPEN',
  `active_user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `opening_note` varchar(1000) DEFAULT NULL,
  `closing_note` varchar(1000) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cashier_shift_balances`
--

CREATE TABLE `cashier_shift_balances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `opening_cash` decimal(18,2) NOT NULL DEFAULT 0.00,
  `counted_cash` decimal(18,2) NOT NULL DEFAULT 0.00,
  `expected_cash` decimal(18,2) NOT NULL DEFAULT 0.00,
  `variance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cashier_shift_entries`
--

CREATE TABLE `cashier_shift_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED NOT NULL,
  `direction` varchar(10) NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `expense_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `legal_name` varchar(190) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `specialization` varchar(150) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dosage_forms`
--

CREATE TABLE `dosage_forms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `expense_date` datetime NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `paid_by` bigint(20) UNSIGNED NOT NULL,
  `payment_method_id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(190) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finance_reconciliations`
--

CREATE TABLE `finance_reconciliations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'RECONCILED',
  `note` varchar(1000) DEFAULT NULL,
  `reconciled_by` bigint(20) UNSIGNED NOT NULL,
  `reconciled_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finance_reconciliation_items`
--

CREATE TABLE `finance_reconciliation_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reconciliation_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `currency_code` varchar(32) NOT NULL,
  `currency_symbol` varchar(32) DEFAULT NULL,
  `opening_cash` decimal(18,2) NOT NULL DEFAULT 0.00,
  `cash_in` decimal(18,2) NOT NULL DEFAULT 0.00,
  `cash_out` decimal(18,2) NOT NULL DEFAULT 0.00,
  `expected_cash` decimal(18,2) NOT NULL DEFAULT 0.00,
  `counted_cash` decimal(18,2) NOT NULL DEFAULT 0.00,
  `variance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `financial_transactions`
--

CREATE TABLE `financial_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `transaction_date` datetime NOT NULL,
  `transaction_type` varchar(40) NOT NULL,
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `amount` decimal(18,2) NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `goods_receipts`
--

CREATE TABLE `goods_receipts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `receipt_date` datetime NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'RECEIVED',
  `received_by` bigint(20) UNSIGNED NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `goods_receipt_items`
--

CREATE TABLE `goods_receipt_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `goods_receipt_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_item_id` bigint(20) UNSIGNED NOT NULL,
  `batch_no` varchar(100) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `mfg_date` date DEFAULT NULL,
  `quantity_received` decimal(18,3) NOT NULL,
  `unit_cost` decimal(18,2) NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `idempotency_keys`
--

CREATE TABLE `idempotency_keys` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `key` varchar(190) NOT NULL,
  `response_hash` char(64) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `import_jobs`
--

CREATE TABLE `import_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `entity_type` varchar(40) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'UPLOADED',
  `original_filename` varchar(255) DEFAULT NULL,
  `stored_path` varchar(255) DEFAULT NULL,
  `file_hash` char(64) NOT NULL,
  `duplicate_strategy` varchar(20) NOT NULL DEFAULT 'skip',
  `total_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `valid_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `error_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `inserted_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `updated_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skipped_rows` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `options` mediumtext DEFAULT NULL,
  `error_report_path` varchar(255) DEFAULT NULL,
  `committed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `import_job_rows`
--

CREATE TABLE `import_job_rows` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_id` bigint(20) UNSIGNED NOT NULL,
  `row_number` int(10) UNSIGNED NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'PENDING',
  `source_json` mediumtext DEFAULT NULL,
  `normalized_json` mediumtext DEFAULT NULL,
  `errors_json` mediumtext DEFAULT NULL,
  `entity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(190) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_batches`
--

CREATE TABLE `inventory_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `goods_receipt_item_id` bigint(20) UNSIGNED DEFAULT NULL,
  `batch_no` varchar(100) NOT NULL,
  `mfg_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `purchase_price` decimal(18,2) NOT NULL,
  `sale_price` decimal(18,2) NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_items`
--

CREATE TABLE `inventory_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `bin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity_on_hand` decimal(18,3) NOT NULL DEFAULT 0.000,
  `quantity_reserved` decimal(18,3) NOT NULL DEFAULT 0.000,
  `reorder_level` decimal(18,3) NOT NULL DEFAULT 0.000,
  `last_movement_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_audit_log`
--

CREATE TABLE `legacy_audit_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(50) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` bigint(20) UNSIGNED NOT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_batch_lots`
--

CREATE TABLE `legacy_batch_lots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `medication_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED DEFAULT NULL,
  `batch_number` varchar(100) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `unit_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `expiry_date` date NOT NULL,
  `received_date` date NOT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_customer_balances`
--

CREATE TABLE `legacy_customer_balances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_dispenses`
--

CREATE TABLE `legacy_dispenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `prescription_id` bigint(20) UNSIGNED NOT NULL,
  `batch_lot_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `dispensed_by` bigint(20) UNSIGNED NOT NULL,
  `dispensed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_expenses`
--

CREATE TABLE `legacy_expenses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `description` text DEFAULT NULL,
  `expense_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_inventory_movements`
--

CREATE TABLE `legacy_inventory_movements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_lot_id` bigint(20) UNSIGNED NOT NULL,
  `movement_type` enum('purchase','sale','dispense','adjust','return','transfer') NOT NULL,
  `quantity` int(11) NOT NULL,
  `quantity_before` int(10) UNSIGNED NOT NULL,
  `quantity_after` int(10) UNSIGNED NOT NULL,
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `performed_by` bigint(20) UNSIGNED NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_invoices`
--

CREATE TABLE `legacy_invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `patient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('draft','pending','paid','partial','cancelled') NOT NULL DEFAULT 'draft',
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `notes` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_invoice_items`
--

CREATE TABLE `legacy_invoice_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED NOT NULL,
  `medication_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_price` decimal(10,2) NOT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_medications`
--

CREATE TABLE `legacy_medications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `generic_name` varchar(255) DEFAULT NULL,
  `brand_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `sku` varchar(100) DEFAULT NULL,
  `barcode` varchar(50) DEFAULT NULL,
  `unit_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `retail_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `reorder_level` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_notifications`
--

CREATE TABLE `legacy_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `priority` enum('low','medium','high','critical') NOT NULL DEFAULT 'medium',
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `entity_type` varchar(50) DEFAULT NULL,
  `entity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_patients`
--

CREATE TABLE `legacy_patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('M','F','Other') DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `notes` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_payments`
--

CREATE TABLE `legacy_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED DEFAULT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `payment_method` enum('cash','card','bank_transfer','mobile') NOT NULL,
  `payment_date` date NOT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `processed_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_prescriptions`
--

CREATE TABLE `legacy_prescriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_name` varchar(255) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('pending','approved','filled','completed','cancelled') NOT NULL DEFAULT 'pending',
  `prescribed_date` date NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_prescription_items`
--

CREATE TABLE `legacy_prescription_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `prescription_id` bigint(20) UNSIGNED NOT NULL,
  `medication_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `dosage` varchar(100) DEFAULT NULL,
  `frequency` varchar(100) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_refunds`
--

CREATE TABLE `legacy_refunds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `reason` text NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `refund_date` date NOT NULL,
  `processed_by` bigint(20) UNSIGNED NOT NULL,
  `approved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_suppliers`
--

CREATE TABLE `legacy_suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT 'AFN',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `legacy_supplier_balances`
--

CREATE TABLE `legacy_supplier_balances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `currency_code` varchar(3) NOT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `last_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE `manufacturers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(190) NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medicines`
--

CREATE TABLE `medicines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sku` varchar(100) NOT NULL,
  `generic_name` varchar(190) NOT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `therapeutic_class_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dosage_form_id` bigint(20) UNSIGNED DEFAULT NULL,
  `route_id` bigint(20) UNSIGNED DEFAULT NULL,
  `strength_id` bigint(20) UNSIGNED DEFAULT NULL,
  `manufacturer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_rx` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ;
-- --------------------------------------------------------

--
-- Table structure for table `medicine_ingredients`
--

CREATE TABLE `medicine_ingredients` (
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `ingredient_id` bigint(20) UNSIGNED NOT NULL,
  `strength` decimal(18,4) DEFAULT NULL,
  `unit` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rule_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(190) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(50) NOT NULL,
  `dedupe_key` varchar(255) DEFAULT NULL,
  `severity` varchar(30) NOT NULL DEFAULT 'INFO',
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `read_at` datetime DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `notification_delivery_logs`
--

CREATE TABLE `notification_delivery_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `notification_id` bigint(20) UNSIGNED NOT NULL,
  `channel` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'PENDING',
  `sent_at` datetime DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `notification_preferences`
--

CREATE TABLE `notification_preferences` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `notification_type` varchar(50) NOT NULL,
  `channel` varchar(30) NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_rules`
--

CREATE TABLE `notification_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `template_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `condition_json` longtext DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `threshold_value` decimal(18,3) DEFAULT NULL,
  `frequency_minutes` int(10) UNSIGNED DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `event_name` varchar(100) NOT NULL,
  `body_template` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `blood_group` varchar(10) DEFAULT NULL,
  `medical_notes` text DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_by` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_date` datetime NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `payment_method_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(190) DEFAULT NULL,
  `received_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(100) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `module` varchar(100) NOT NULL,
  `action` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prescriptions`
--

CREATE TABLE `prescriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `patient_id` bigint(20) UNSIGNED DEFAULT NULL,
  `prescription_no` varchar(60) DEFAULT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `prescription_date` date NOT NULL,
  `diagnosis` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `approved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prescription_items`
--

CREATE TABLE `prescription_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `prescription_id` bigint(20) UNSIGNED NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `quantity_prescribed` decimal(18,3) DEFAULT NULL,
  `dosage` varchar(100) DEFAULT NULL,
  `frequency` varchar(100) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_identifiers`
--

CREATE TABLE `product_identifiers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `identifier_type` varchar(30) NOT NULL,
  `identifier_value` varchar(190) NOT NULL,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_items`
--

CREATE TABLE `purchase_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` bigint(20) UNSIGNED NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `quantity_ordered` decimal(18,3) NOT NULL,
  `purchase_unit` varchar(30) NOT NULL DEFAULT 'Piece',
  `unit_price` decimal(18,2) NOT NULL,
  `discount_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_rate_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_rate_percent` decimal(9,4) DEFAULT NULL,
  `total_amount` decimal(18,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_item_closures`
--

CREATE TABLE `purchase_item_closures` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_item_id` bigint(20) UNSIGNED NOT NULL,
  `quantity_closed` decimal(18,3) NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `closed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `closed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `order_date` datetime NOT NULL,
  `expected_date` datetime DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'DRAFT',
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `paid_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `due_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `payment_status` varchar(20) NOT NULL DEFAULT 'UNPAID',
  `notes` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_returns`
--

CREATE TABLE `purchase_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `return_date` datetime NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'COMPLETED',
  `gross_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `refund_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `refund_method_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return_items`
--

CREATE TABLE `purchase_return_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_return_id` bigint(20) UNSIGNED NOT NULL,
  `goods_receipt_item_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_item_id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED NOT NULL,
  `inventory_item_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(18,3) NOT NULL,
  `unit_cost` decimal(18,2) NOT NULL,
  `gross_amount` decimal(18,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `return_items`
--

CREATE TABLE `return_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_return_id` bigint(20) UNSIGNED NOT NULL,
  `sale_item_id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` decimal(18,3) NOT NULL,
  `unit_price` decimal(18,2) NOT NULL,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_rate_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_rate_percent` decimal(9,4) DEFAULT NULL,
  `total_amount` decimal(18,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `permission_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `invoice_no` varchar(100) NOT NULL,
  `invoice_date` datetime NOT NULL,
  `sale_type` varchar(30) NOT NULL DEFAULT 'POS',
  `discount_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(18,2) NOT NULL,
  `amount_paid` decimal(18,2) NOT NULL DEFAULT 0.00,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'COMPLETED',
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `medicine_id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` decimal(18,3) NOT NULL,
  `unit_price` decimal(18,2) NOT NULL,
  `discount_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `tax_rate_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_rate_percent` decimal(9,4) DEFAULT NULL,
  `total_amount` decimal(18,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `sale_returns`
--

CREATE TABLE `sale_returns` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sale_id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `return_date` datetime NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'COMPLETED',
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_scope_key` bigint(20) UNSIGNED GENERATED ALWAYS AS (coalesce(`branch_id`,0)) STORED,
  `key` varchar(150) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(30) NOT NULL DEFAULT 'STRING',
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_adjustments`
--

CREATE TABLE `stock_adjustments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED DEFAULT NULL,
  `bin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` varchar(190) NOT NULL,
  `quantity` decimal(18,3) NOT NULL,
  `unit_cost` decimal(18,2) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `from_bin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `to_bin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `movement_type` varchar(40) NOT NULL,
  `reference_type` varchar(50) DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` decimal(18,3) NOT NULL,
  `unit_cost` decimal(18,2) DEFAULT NULL,
  `current_cost` decimal(18,2) DEFAULT NULL,
  `currency_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfers`
--

CREATE TABLE `stock_transfers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `from_warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `to_warehouse_id` bigint(20) UNSIGNED NOT NULL,
  `transfer_date` datetime NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'DRAFT',
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `stock_transfer_items`
--

CREATE TABLE `stock_transfer_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stock_transfer_id` bigint(20) UNSIGNED NOT NULL,
  `batch_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` decimal(18,3) NOT NULL,
  `from_bin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `to_bin_id` bigint(20) UNSIGNED DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `strengths`
--

CREATE TABLE `strengths` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(190) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_balances`
--

CREATE TABLE `supplier_balances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `opening_balance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `current_balance` decimal(18,2) NOT NULL DEFAULT 0.00,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplier_payments`
--

CREATE TABLE `supplier_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supplier_id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_date` datetime NOT NULL,
  `amount` decimal(18,2) NOT NULL,
  `payment_method_id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(190) DEFAULT NULL,
  `paid_by` bigint(20) UNSIGNED NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `rate_percent` decimal(9,4) NOT NULL DEFAULT 0.0000,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `therapeutic_classes`
--

CREATE TABLE `therapeutic_classes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(190) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(190) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_scope_key` bigint(20) UNSIGNED GENERATED ALWAYS AS (coalesce(`branch_id`,0)) STORED,
  `assigned_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `last_activity` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(190) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'ACTIVE',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applied_migrations`
--
ALTER TABLE `applied_migrations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_applied_migrations_version` (`migration_version`),
  ADD UNIQUE KEY `uq_applied_migrations_file` (`migration_file`),
  ADD KEY `idx_applied_migrations_checksum` (`checksum`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_logs_user_id` (`user_id`),
  ADD KEY `idx_audit_logs_table_record` (`table_name`,`record_id`),
  ADD KEY `idx_audit_logs_created_at` (`created_at`);

--
-- Indexes for table `backup_jobs`
--
ALTER TABLE `backup_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_backup_jobs_status` (`status`),
  ADD KEY `idx_backup_jobs_type` (`backup_type`),
  ADD KEY `idx_backup_jobs_user` (`user_id`),
  ADD KEY `idx_backup_jobs_created` (`created_at`),
  ADD KEY `idx_backup_jobs_schedule` (`schedule_id`);

--
-- Indexes for table `backup_restores`
--
ALTER TABLE `backup_restores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_backup_restores_backup` (`backup_job_id`),
  ADD KEY `idx_backup_restores_user` (`user_id`),
  ADD KEY `idx_backup_restores_status` (`status`);

--
-- Indexes for table `backup_schedules`
--
ALTER TABLE `backup_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_backup_schedules_due` (`enabled`,`next_run_at`),
  ADD KEY `idx_backup_schedules_created` (`created_at`),
  ADD KEY `fk_backup_schedules_created_by` (`created_by`),
  ADD KEY `fk_backup_schedules_updated_by` (`updated_by`);

--
-- Indexes for table `backup_schedule_runs`
--
ALTER TABLE `backup_schedule_runs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_backup_schedule_runs_schedule` (`schedule_id`),
  ADD KEY `idx_backup_schedule_runs_job` (`backup_job_id`),
  ADD KEY `idx_backup_schedule_runs_status` (`status`),
  ADD KEY `idx_backup_schedule_runs_started` (`started_at`);

--
-- Indexes for table `bins`
--
ALTER TABLE `bins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_bins_warehouse_code` (`warehouse_id`,`code`),
  ADD UNIQUE KEY `uq_bins_id_warehouse` (`id`,`warehouse_id`),
  ADD KEY `idx_bins_warehouse_id` (`warehouse_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_branches_code` (`code`),
  ADD KEY `idx_branches_company_id` (`company_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_brands_name` (`name`);

--
-- Indexes for table `cashier_shifts`
--
ALTER TABLE `cashier_shifts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cashier_shifts_active_user` (`active_user_id`),
  ADD KEY `idx_cashier_shifts_branch_status` (`branch_id`,`status`),
  ADD KEY `idx_cashier_shifts_opened_by_status` (`opened_by`,`status`),
  ADD KEY `idx_cashier_shifts_opened_at` (`opened_at`),
  ADD KEY `idx_cashier_shifts_closed_at` (`closed_at`),
  ADD KEY `fk_cashier_shifts_closed_by` (`closed_by`);

--
-- Indexes for table `cashier_shift_balances`
--
ALTER TABLE `cashier_shift_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cashier_shift_balances_shift_currency` (`shift_id`,`currency_id`),
  ADD KEY `idx_cashier_shift_balances_currency` (`currency_id`);

--
-- Indexes for table `cashier_shift_entries`
--
ALTER TABLE `cashier_shift_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_cashier_shift_entries_expense_id` (`expense_id`),
  ADD KEY `idx_cashier_shift_entries_shift` (`shift_id`),
  ADD KEY `idx_cashier_shift_entries_currency` (`currency_id`),
  ADD KEY `idx_cashier_shift_entries_created_at` (`created_at`),
  ADD KEY `fk_cashier_shift_entries_created_by` (`created_by`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_categories_name_parent` (`name`,`parent_id`),
  ADD KEY `idx_categories_parent_id` (`parent_id`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_companies_code` (`code`),
  ADD KEY `idx_companies_status` (`status`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_currencies_code` (`code`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_customers_code` (`code`),
  ADD KEY `idx_customers_name` (`name`),
  ADD KEY `idx_customers_phone` (`phone`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_doctors_code` (`code`),
  ADD KEY `idx_doctors_name` (`name`);

--
-- Indexes for table `dosage_forms`
--
ALTER TABLE `dosage_forms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_dosage_forms_name` (`name`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_expenses_branch_id` (`branch_id`),
  ADD KEY `idx_expenses_category_id` (`category_id`),
  ADD KEY `idx_expenses_currency_id` (`currency_id`),
  ADD KEY `idx_expenses_paid_by` (`paid_by`),
  ADD KEY `idx_expenses_expense_date` (`expense_date`),
  ADD KEY `idx_expenses_payment_method_id` (`payment_method_id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_expense_categories_name_parent` (`name`,`parent_id`),
  ADD KEY `idx_expense_categories_parent_id` (`parent_id`);

--
-- Indexes for table `finance_reconciliations`
--
ALTER TABLE `finance_reconciliations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_finance_reconciliations_shift` (`shift_id`),
  ADD KEY `idx_finance_reconciliations_branch_status` (`branch_id`,`status`),
  ADD KEY `idx_finance_reconciliations_reconciled_at` (`reconciled_at`),
  ADD KEY `idx_finance_reconciliations_reconciled_by` (`reconciled_by`);

--
-- Indexes for table `finance_reconciliation_items`
--
ALTER TABLE `finance_reconciliation_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_finance_reconciliation_currency` (`reconciliation_id`,`currency_id`),
  ADD KEY `idx_finance_reconciliation_items_currency` (`currency_id`);

--
-- Indexes for table `financial_transactions`
--
ALTER TABLE `financial_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_financial_transactions_branch_id` (`branch_id`),
  ADD KEY `idx_financial_transactions_date` (`transaction_date`),
  ADD KEY `idx_financial_transactions_reference` (`reference_type`,`reference_id`),
  ADD KEY `idx_financial_transactions_currency_id` (`currency_id`),
  ADD KEY `fk_financial_transactions_created_by` (`created_by`);

--
-- Indexes for table `goods_receipts`
--
ALTER TABLE `goods_receipts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_goods_receipts_branch_id` (`branch_id`),
  ADD KEY `idx_goods_receipts_received_by` (`received_by`),
  ADD KEY `idx_goods_receipts_purchase_order_branch` (`purchase_order_id`,`branch_id`);

--
-- Indexes for table `goods_receipt_items`
--
ALTER TABLE `goods_receipt_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_goods_receipt_items_receipt_id` (`goods_receipt_id`),
  ADD KEY `idx_goods_receipt_items_purchase_item_id` (`purchase_item_id`),
  ADD KEY `idx_goods_receipt_items_currency_id` (`currency_id`),
  ADD KEY `idx_goods_receipt_items_batch_no` (`batch_no`);

--
-- Indexes for table `idempotency_keys`
--
ALTER TABLE `idempotency_keys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_idempotency_user_key` (`user_id`,`key`),
  ADD KEY `idx_idempotency_expires_at` (`expires_at`);

--
-- Indexes for table `import_jobs`
--
ALTER TABLE `import_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_import_jobs_entity` (`entity_type`),
  ADD KEY `idx_import_jobs_status` (`status`),
  ADD KEY `idx_import_jobs_user` (`user_id`),
  ADD KEY `idx_import_jobs_created` (`created_at`);

--
-- Indexes for table `import_job_rows`
--
ALTER TABLE `import_job_rows`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_import_job_row` (`job_id`,`row_number`),
  ADD KEY `idx_import_job_rows_status` (`job_id`,`status`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ingredients_name` (`name`);

--
-- Indexes for table `inventory_batches`
--
ALTER TABLE `inventory_batches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_inventory_batches_medicine_batch` (`medicine_id`,`batch_no`),
  ADD UNIQUE KEY `uq_inventory_batches_id_medicine` (`id`,`medicine_id`),
  ADD KEY `idx_inventory_batches_currency_id` (`currency_id`),
  ADD KEY `idx_inventory_batches_expiry_date` (`expiry_date`),
  ADD KEY `idx_inventory_batches_supplier_id` (`supplier_id`),
  ADD KEY `idx_inventory_batches_goods_receipt_item_id` (`goods_receipt_item_id`);
--
-- Indexes for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_inventory_items_batch_warehouse_bin` (`batch_id`,`warehouse_id`,`bin_id`),
  ADD KEY `idx_inventory_items_batch_id` (`batch_id`),
  ADD KEY `idx_inventory_items_branch_id` (`branch_id`),
  ADD KEY `idx_inventory_items_warehouse_branch` (`warehouse_id`,`branch_id`),
  ADD KEY `idx_inventory_items_bin_warehouse` (`bin_id`,`warehouse_id`),
  ADD KEY `idx_inventory_items_branch_warehouse_bin_batch` (`branch_id`,`warehouse_id`,`bin_id`,`batch_id`),
  ADD KEY `idx_inventory_items_warehouse_bin_last_movement` (`warehouse_id`,`bin_id`,`last_movement_at`);

--
-- Indexes for table `legacy_audit_log`
--
ALTER TABLE `legacy_audit_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_log_user_id` (`user_id`),
  ADD KEY `idx_audit_log_action` (`action`),
  ADD KEY `idx_audit_log_table_name` (`table_name`),
  ADD KEY `idx_audit_log_record_id` (`record_id`),
  ADD KEY `idx_audit_log_created_at` (`created_at`),
  ADD KEY `idx_audit_log_entity` (`table_name`,`record_id`);

--
-- Indexes for table `legacy_batch_lots`
--
ALTER TABLE `legacy_batch_lots`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_batch_medication` (`medication_id`,`batch_number`),
  ADD KEY `idx_batch_lots_supplier_id` (`supplier_id`),
  ADD KEY `idx_batch_lots_expiry_date` (`expiry_date`),
  ADD KEY `idx_batch_lots_branch_id` (`branch_id`),
  ADD KEY `idx_batch_lots_currency_code` (`currency_code`),
  ADD KEY `idx_batch_lots_is_active` (`is_active`),
  ADD KEY `idx_batch_lots_deleted_at` (`deleted_at`),
  ADD KEY `idx_batch_lots_received_date` (`received_date`);

--
-- Indexes for table `legacy_customer_balances`
--
ALTER TABLE `legacy_customer_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_patient_currency` (`patient_id`,`currency_code`),
  ADD KEY `currency_code` (`currency_code`);

--
-- Indexes for table `legacy_dispenses`
--
ALTER TABLE `legacy_dispenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dispenses_prescription_id` (`prescription_id`),
  ADD KEY `idx_dispenses_batch_lot_id` (`batch_lot_id`),
  ADD KEY `idx_dispenses_dispensed_at` (`dispensed_at`),
  ADD KEY `dispensed_by` (`dispensed_by`);

--
-- Indexes for table `legacy_expenses`
--
ALTER TABLE `legacy_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_expenses_category_id` (`category_id`),
  ADD KEY `idx_expenses_branch_id` (`branch_id`),
  ADD KEY `idx_expenses_expense_date` (`expense_date`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `currency_code` (`currency_code`);

--
-- Indexes for table `legacy_inventory_movements`
--
ALTER TABLE `legacy_inventory_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_inventory_movements_batch_lot_id` (`batch_lot_id`),
  ADD KEY `idx_inventory_movements_movement_type` (`movement_type`),
  ADD KEY `idx_inventory_movements_created_at` (`created_at`),
  ADD KEY `idx_inventory_movements_reference` (`reference_type`,`reference_id`),
  ADD KEY `performed_by` (`performed_by`);

--
-- Indexes for table `legacy_invoices`
--
ALTER TABLE `legacy_invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_invoices_number` (`invoice_number`),
  ADD KEY `idx_invoices_patient_id` (`patient_id`),
  ADD KEY `idx_invoices_branch_id` (`branch_id`),
  ADD KEY `idx_invoices_status` (`status`),
  ADD KEY `idx_invoices_currency_code` (`currency_code`),
  ADD KEY `idx_invoices_created_by` (`created_by`),
  ADD KEY `idx_invoices_created_at` (`created_at`),
  ADD KEY `idx_invoices_deleted_at` (`deleted_at`),
  ADD KEY `idx_invoices_status_created` (`status`,`created_at`);

--
-- Indexes for table `legacy_invoice_items`
--
ALTER TABLE `legacy_invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_invoice_items_invoice_id` (`invoice_id`),
  ADD KEY `idx_invoice_items_medication_id` (`medication_id`),
  ADD KEY `currency_code` (`currency_code`);

--
-- Indexes for table `legacy_medications`
--
ALTER TABLE `legacy_medications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_medications_sku` (`sku`),
  ADD UNIQUE KEY `uk_medications_barcode` (`barcode`),
  ADD KEY `idx_medications_name` (`name`),
  ADD KEY `idx_medications_generic_name` (`generic_name`),
  ADD KEY `idx_medications_category` (`category`),
  ADD KEY `idx_medications_currency_code` (`currency_code`),
  ADD KEY `idx_medications_is_active` (`is_active`),
  ADD KEY `idx_medications_deleted_at` (`deleted_at`);

--
-- Indexes for table `legacy_notifications`
--
ALTER TABLE `legacy_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notifications_type` (`type`),
  ADD KEY `idx_notifications_is_read` (`is_read`),
  ADD KEY `idx_notifications_created_at` (`created_at`),
  ADD KEY `idx_notifications_entity` (`entity_type`,`entity_id`),
  ADD KEY `rule_id` (`rule_id`);

--
-- Indexes for table `legacy_patients`
--
ALTER TABLE `legacy_patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_patients_name` (`last_name`,`first_name`),
  ADD KEY `idx_patients_phone` (`phone`),
  ADD KEY `idx_patients_email` (`email`),
  ADD KEY `idx_patients_currency_code` (`currency_code`),
  ADD KEY `idx_patients_is_active` (`is_active`),
  ADD KEY `idx_patients_deleted_at` (`deleted_at`);

--
-- Indexes for table `legacy_payments`
--
ALTER TABLE `legacy_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_payments_invoice_id` (`invoice_id`),
  ADD KEY `idx_payments_patient_id` (`patient_id`),
  ADD KEY `idx_payments_payment_method` (`payment_method`),
  ADD KEY `idx_payments_payment_date` (`payment_date`),
  ADD KEY `idx_payments_created_at` (`created_at`),
  ADD KEY `currency_code` (`currency_code`),
  ADD KEY `processed_by` (`processed_by`);

--
-- Indexes for table `legacy_prescriptions`
--
ALTER TABLE `legacy_prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prescriptions_patient_id` (`patient_id`),
  ADD KEY `idx_prescriptions_status` (`status`),
  ADD KEY `idx_prescriptions_prescribed_date` (`prescribed_date`),
  ADD KEY `idx_prescriptions_created_by` (`created_by`),
  ADD KEY `idx_prescriptions_deleted_at` (`deleted_at`);

--
-- Indexes for table `legacy_prescription_items`
--
ALTER TABLE `legacy_prescription_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prescription_items_prescription_id` (`prescription_id`),
  ADD KEY `idx_prescription_items_medication_id` (`medication_id`);

--
-- Indexes for table `legacy_refunds`
--
ALTER TABLE `legacy_refunds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_refunds_payment_id` (`payment_id`),
  ADD KEY `idx_refunds_invoice_id` (`invoice_id`),
  ADD KEY `idx_refunds_status` (`status`),
  ADD KEY `idx_refunds_refund_date` (`refund_date`),
  ADD KEY `currency_code` (`currency_code`),
  ADD KEY `processed_by` (`processed_by`),
  ADD KEY `approved_by` (`approved_by`);

--
-- Indexes for table `legacy_suppliers`
--
ALTER TABLE `legacy_suppliers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_suppliers_name` (`name`),
  ADD KEY `idx_suppliers_phone` (`phone`),
  ADD KEY `idx_suppliers_currency_code` (`currency_code`),
  ADD KEY `idx_suppliers_is_active` (`is_active`),
  ADD KEY `idx_suppliers_deleted_at` (`deleted_at`);

--
-- Indexes for table `legacy_supplier_balances`
--
ALTER TABLE `legacy_supplier_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_supplier_currency` (`supplier_id`,`currency_code`),
  ADD KEY `currency_code` (`currency_code`);

--
-- Indexes for table `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_manufacturers_name` (`name`);

--
-- Indexes for table `medicines`
--
ALTER TABLE `medicines`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_medicines_sku` (`sku`),
  ADD KEY `idx_medicines_generic_name` (`generic_name`),
  ADD KEY `idx_medicines_brand_id` (`brand_id`),
  ADD KEY `idx_medicines_category_id` (`category_id`),
  ADD KEY `idx_medicines_therapeutic_class_id` (`therapeutic_class_id`),
  ADD KEY `idx_medicines_dosage_form_id` (`dosage_form_id`),
  ADD KEY `idx_medicines_route_id` (`route_id`),
  ADD KEY `idx_medicines_strength_id` (`strength_id`),
  ADD KEY `idx_medicines_manufacturer_id` (`manufacturer_id`);

--
-- Indexes for table `medicine_ingredients`
--
ALTER TABLE `medicine_ingredients`
  ADD PRIMARY KEY (`medicine_id`,`ingredient_id`),
  ADD KEY `idx_medicine_ingredients_ingredient_id` (`ingredient_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_notifications_dedupe_key` (`dedupe_key`),
  ADD KEY `idx_notifications_rule_id` (`rule_id`),
  ADD KEY `idx_notifications_user_id` (`user_id`),
  ADD KEY `idx_notifications_read` (`user_id`,`is_read`),
  ADD KEY `idx_notifications_reference` (`reference_type`,`reference_id`);

--
-- Indexes for table `notification_delivery_logs`
--
ALTER TABLE `notification_delivery_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_notification_delivery` (`notification_id`,`channel`),
  ADD KEY `idx_notification_delivery_status` (`status`);

--
-- Indexes for table `notification_preferences`
--
ALTER TABLE `notification_preferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_notification_preferences_user_type_channel` (`user_id`,`notification_type`,`channel`),
  ADD KEY `idx_notification_preferences_type` (`notification_type`);

--
-- Indexes for table `notification_rules`
--
ALTER TABLE `notification_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_notification_rules_template_id` (`template_id`),
  ADD KEY `idx_notification_rules_branch_id` (`branch_id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_notification_templates_code` (`code`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_patients_code` (`patient_code`),
  ADD KEY `idx_patients_customer_id` (`customer_id`),
  ADD KEY `idx_patients_name` (`name`),
  ADD KEY `idx_patients_phone` (`phone`),
  ADD KEY `idx_patients_status` (`status`),
  ADD KEY `fk_patients_created_by` (`created_by`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_payments_currency_id` (`currency_id`),
  ADD KEY `idx_payments_received_by` (`received_by`),
  ADD KEY `idx_payments_payment_method_id` (`payment_method_id`),
  ADD KEY `idx_payments_sale_currency` (`sale_id`,`currency_id`),
  ADD KEY `idx_payments_shift_id` (`shift_id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_payment_methods_code` (`code`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_permissions_name` (`name`),
  ADD KEY `idx_permissions_module` (`module`);

--
-- Indexes for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_prescriptions_no` (`prescription_no`),
  ADD KEY `idx_prescriptions_customer_id` (`customer_id`),
  ADD KEY `idx_prescriptions_doctor_id` (`doctor_id`),
  ADD KEY `idx_prescriptions_created_by` (`created_by`),
  ADD KEY `idx_prescriptions_date` (`prescription_date`),
  ADD KEY `idx_prescriptions_patient_id` (`patient_id`),
  ADD KEY `idx_prescriptions_status` (`status`),
  ADD KEY `idx_prescriptions_deleted_at` (`deleted_at`),
  ADD KEY `fk_prescriptions_approved_by` (`approved_by`);

--
-- Indexes for table `prescription_items`
--
ALTER TABLE `prescription_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prescription_items_prescription_id` (`prescription_id`),
  ADD KEY `idx_prescription_items_medicine_id` (`medicine_id`);

--
-- Indexes for table `product_identifiers`
--
ALTER TABLE `product_identifiers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_product_identifiers_value` (`identifier_type`,`identifier_value`),
  ADD KEY `idx_product_identifiers_medicine_id` (`medicine_id`),
  ADD KEY `idx_product_identifiers_value_medicine_active` (`identifier_value`,`medicine_id`,`is_active`);

--
-- Indexes for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_purchase_items_order_id` (`purchase_order_id`),
  ADD KEY `idx_purchase_items_medicine_id` (`medicine_id`),
  ADD KEY `idx_purchase_items_tax_rate_id` (`tax_rate_id`),
  ADD KEY `idx_purchase_items_purchase_unit` (`purchase_unit`);

--
-- Indexes for table `purchase_item_closures`
--
ALTER TABLE `purchase_item_closures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_purchase_item_closures_po` (`purchase_order_id`),
  ADD KEY `idx_purchase_item_closures_item` (`purchase_item_id`),
  ADD KEY `idx_purchase_item_closures_user` (`closed_by`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_purchase_orders_id_branch` (`id`,`branch_id`),
  ADD KEY `idx_purchase_orders_branch_id` (`branch_id`),
  ADD KEY `idx_purchase_orders_supplier_id` (`supplier_id`),
  ADD KEY `idx_purchase_orders_currency_id` (`currency_id`),
  ADD KEY `idx_purchase_orders_created_by` (`created_by`),
  ADD KEY `idx_purchase_orders_order_date` (`order_date`),
  ADD KEY `idx_purchase_orders_payment_status` (`payment_status`);

--
-- Indexes for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_purchase_returns_po` (`purchase_order_id`),
  ADD KEY `idx_purchase_returns_branch` (`branch_id`),
  ADD KEY `idx_purchase_returns_supplier` (`supplier_id`),
  ADD KEY `idx_purchase_returns_currency` (`currency_id`),
  ADD KEY `idx_purchase_returns_refund_method` (`refund_method_id`),
  ADD KEY `idx_purchase_returns_created_by` (`created_by`);

--
-- Indexes for table `purchase_return_items`
--
ALTER TABLE `purchase_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_purchase_return_items_return` (`purchase_return_id`),
  ADD KEY `idx_purchase_return_items_receipt_item` (`goods_receipt_item_id`),
  ADD KEY `idx_purchase_return_items_purchase_item` (`purchase_item_id`),
  ADD KEY `idx_purchase_return_items_batch` (`batch_id`),
  ADD KEY `idx_purchase_return_items_inventory` (`inventory_item_id`);

--
-- Indexes for table `return_items`
--
ALTER TABLE `return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_return_items_sale_return_id` (`sale_return_id`),
  ADD KEY `idx_return_items_sale_item_id` (`sale_item_id`),
  ADD KEY `idx_return_items_batch_id` (`batch_id`),
  ADD KEY `idx_return_items_tax_rate_id` (`tax_rate_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_roles_name` (`name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `idx_role_permissions_permission_id` (`permission_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_routes_name` (`name`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_sales_branch_invoice_no` (`branch_id`,`invoice_no`),
  ADD UNIQUE KEY `uq_sales_id_currency` (`id`,`currency_id`),
  ADD KEY `idx_sales_customer_id` (`customer_id`),
  ADD KEY `idx_sales_currency_id` (`currency_id`),
  ADD KEY `idx_sales_created_by` (`created_by`),
  ADD KEY `idx_sales_invoice_date` (`invoice_date`),
  ADD KEY `idx_sales_shift_id` (`shift_id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sale_items_sale_id` (`sale_id`),
  ADD KEY `idx_sale_items_medicine_id` (`medicine_id`),
  ADD KEY `idx_sale_items_tax_rate_id` (`tax_rate_id`),
  ADD KEY `idx_sale_items_batch_medicine` (`batch_id`,`medicine_id`);

--
-- Indexes for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_sale_returns_sale_id` (`sale_id`),
  ADD KEY `idx_sale_returns_created_by` (`created_by`),
  ADD KEY `idx_sale_returns_shift_id` (`shift_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_settings_scope_key` (`key`,`branch_scope_key`),
  ADD KEY `idx_settings_branch_id` (`branch_id`);

--
-- Indexes for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stock_adjustments_batch_id` (`batch_id`),
  ADD KEY `idx_stock_adjustments_branch_id` (`branch_id`),
  ADD KEY `idx_stock_adjustments_created_by` (`created_by`),
  ADD KEY `idx_stock_adjustments_warehouse_id` (`warehouse_id`),
  ADD KEY `idx_stock_adjustments_bin_id` (`bin_id`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stock_movements_batch_id` (`batch_id`),
  ADD KEY `idx_stock_movements_branch_id` (`branch_id`),
  ADD KEY `idx_stock_movements_from_bin_id` (`from_bin_id`),
  ADD KEY `idx_stock_movements_to_bin_id` (`to_bin_id`),
  ADD KEY `idx_stock_movements_reference` (`reference_type`,`reference_id`),
  ADD KEY `idx_stock_movements_created_at` (`created_at`),
  ADD KEY `fk_stock_movements_currency` (`currency_id`),
  ADD KEY `fk_stock_movements_created_by` (`created_by`),
  ADD KEY `idx_stock_movements_warehouse_branch` (`warehouse_id`,`branch_id`),
  ADD KEY `idx_stock_movements_warehouse_created_at` (`warehouse_id`,`created_at`);

--
-- Indexes for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stock_transfers_branch_id` (`branch_id`),
  ADD KEY `fk_stock_transfers_created_by` (`created_by`),
  ADD KEY `idx_stock_transfers_from_warehouse_branch` (`from_warehouse_id`,`branch_id`),
  ADD KEY `idx_stock_transfers_to_warehouse_branch` (`to_warehouse_id`,`branch_id`);

--
-- Indexes for table `stock_transfer_items`
--
ALTER TABLE `stock_transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_stock_transfer_items_transfer_id` (`stock_transfer_id`),
  ADD KEY `idx_stock_transfer_items_batch_id` (`batch_id`),
  ADD KEY `fk_stock_transfer_items_from_bin` (`from_bin_id`),
  ADD KEY `fk_stock_transfer_items_to_bin` (`to_bin_id`);

--
-- Indexes for table `strengths`
--
ALTER TABLE `strengths`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_strengths_name` (`name`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_suppliers_code` (`code`),
  ADD KEY `idx_suppliers_name` (`name`);

--
-- Indexes for table `supplier_balances`
--
ALTER TABLE `supplier_balances`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_supplier_balances_supplier_currency` (`supplier_id`,`currency_id`),
  ADD KEY `idx_supplier_balances_currency_id` (`currency_id`);

--
-- Indexes for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_supplier_payments_supplier_id` (`supplier_id`),
  ADD KEY `idx_supplier_payments_currency_id` (`currency_id`),
  ADD KEY `idx_supplier_payments_paid_by` (`paid_by`),
  ADD KEY `idx_supplier_payments_payment_method_id` (`payment_method_id`),
  ADD KEY `idx_supplier_payments_purchase_order_id` (`purchase_order_id`);

--
-- Indexes for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tax_rates_name` (`name`);

--
-- Indexes for table `therapeutic_classes`
--
ALTER TABLE `therapeutic_classes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_therapeutic_classes_code` (`code`),
  ADD UNIQUE KEY `uq_therapeutic_classes_name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_users_username` (`username`),
  ADD UNIQUE KEY `uq_users_email` (`email`),
  ADD KEY `idx_users_status` (`status`),
  ADD KEY `idx_users_full_name` (`full_name`),
  ADD KEY `idx_users_phone` (`phone`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_roles_assignment` (`user_id`,`role_id`,`branch_scope_key`),
  ADD KEY `idx_user_roles_role_id` (`role_id`),
  ADD KEY `idx_user_roles_branch_id` (`branch_id`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_sessions_token_hash` (`token_hash`),
  ADD KEY `idx_user_sessions_user_id` (`user_id`),
  ADD KEY `idx_user_sessions_expires_at` (`expires_at`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_warehouses_branch_code` (`branch_id`,`code`),
  ADD UNIQUE KEY `uq_warehouses_id_branch` (`id`,`branch_id`),
  ADD KEY `idx_warehouses_branch_id` (`branch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applied_migrations`
--
ALTER TABLE `applied_migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backup_jobs`
--
ALTER TABLE `backup_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backup_restores`
--
ALTER TABLE `backup_restores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backup_schedules`
--
ALTER TABLE `backup_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `backup_schedule_runs`
--
ALTER TABLE `backup_schedule_runs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bins`
--
ALTER TABLE `bins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cashier_shifts`
--
ALTER TABLE `cashier_shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cashier_shift_balances`
--
ALTER TABLE `cashier_shift_balances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cashier_shift_entries`
--
ALTER TABLE `cashier_shift_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dosage_forms`
--
ALTER TABLE `dosage_forms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finance_reconciliations`
--
ALTER TABLE `finance_reconciliations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finance_reconciliation_items`
--
ALTER TABLE `finance_reconciliation_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `financial_transactions`
--
ALTER TABLE `financial_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `goods_receipts`
--
ALTER TABLE `goods_receipts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `goods_receipt_items`
--
ALTER TABLE `goods_receipt_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `idempotency_keys`
--
ALTER TABLE `idempotency_keys`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `import_jobs`
--
ALTER TABLE `import_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `import_job_rows`
--
ALTER TABLE `import_job_rows`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_batches`
--
ALTER TABLE `inventory_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory_items`
--
ALTER TABLE `inventory_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_audit_log`
--
ALTER TABLE `legacy_audit_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_batch_lots`
--
ALTER TABLE `legacy_batch_lots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_customer_balances`
--
ALTER TABLE `legacy_customer_balances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_dispenses`
--
ALTER TABLE `legacy_dispenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_expenses`
--
ALTER TABLE `legacy_expenses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_inventory_movements`
--
ALTER TABLE `legacy_inventory_movements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_invoices`
--
ALTER TABLE `legacy_invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_invoice_items`
--
ALTER TABLE `legacy_invoice_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_medications`
--
ALTER TABLE `legacy_medications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_notifications`
--
ALTER TABLE `legacy_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_patients`
--
ALTER TABLE `legacy_patients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_payments`
--
ALTER TABLE `legacy_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_prescriptions`
--
ALTER TABLE `legacy_prescriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_prescription_items`
--
ALTER TABLE `legacy_prescription_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_refunds`
--
ALTER TABLE `legacy_refunds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_suppliers`
--
ALTER TABLE `legacy_suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `legacy_supplier_balances`
--
ALTER TABLE `legacy_supplier_balances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medicines`
--
ALTER TABLE `medicines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_delivery_logs`
--
ALTER TABLE `notification_delivery_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_preferences`
--
ALTER TABLE `notification_preferences`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_rules`
--
ALTER TABLE `notification_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prescriptions`
--
ALTER TABLE `prescriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prescription_items`
--
ALTER TABLE `prescription_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_identifiers`
--
ALTER TABLE `product_identifiers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_items`
--
ALTER TABLE `purchase_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_item_closures`
--
ALTER TABLE `purchase_item_closures`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_return_items`
--
ALTER TABLE `purchase_return_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `return_items`
--
ALTER TABLE `return_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sale_returns`
--
ALTER TABLE `sale_returns`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_transfer_items`
--
ALTER TABLE `stock_transfer_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `strengths`
--
ALTER TABLE `strengths`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier_balances`
--
ALTER TABLE `supplier_balances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `therapeutic_classes`
--
ALTER TABLE `therapeutic_classes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_roles`
--
ALTER TABLE `user_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `backup_jobs`
--
ALTER TABLE `backup_jobs`
  ADD CONSTRAINT `fk_backup_jobs_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `backup_schedules` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_backup_jobs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `backup_restores`
--
ALTER TABLE `backup_restores`
  ADD CONSTRAINT `fk_backup_restores_backup` FOREIGN KEY (`backup_job_id`) REFERENCES `backup_jobs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_backup_restores_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `backup_schedules`
--
ALTER TABLE `backup_schedules`
  ADD CONSTRAINT `fk_backup_schedules_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_backup_schedules_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `backup_schedule_runs`
--
ALTER TABLE `backup_schedule_runs`
  ADD CONSTRAINT `fk_backup_schedule_runs_job` FOREIGN KEY (`backup_job_id`) REFERENCES `backup_jobs` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_backup_schedule_runs_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `backup_schedules` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bins`
--
ALTER TABLE `bins`
  ADD CONSTRAINT `fk_bins_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `fk_branches_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `cashier_shifts`
--
ALTER TABLE `cashier_shifts`
  ADD CONSTRAINT `fk_cashier_shifts_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cashier_shifts_closed_by` FOREIGN KEY (`closed_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cashier_shifts_opened_by` FOREIGN KEY (`opened_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `cashier_shift_balances`
--
ALTER TABLE `cashier_shift_balances`
  ADD CONSTRAINT `fk_cashier_shift_balances_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cashier_shift_balances_shift` FOREIGN KEY (`shift_id`) REFERENCES `cashier_shifts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cashier_shift_entries`
--
ALTER TABLE `cashier_shift_entries`
  ADD CONSTRAINT `fk_cashier_shift_entries_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cashier_shift_entries_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cashier_shift_entries_expense` FOREIGN KEY (`expense_id`) REFERENCES `expenses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cashier_shift_entries_shift` FOREIGN KEY (`shift_id`) REFERENCES `cashier_shifts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_parent` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `expenses`
--
ALTER TABLE `expenses`
  ADD CONSTRAINT `fk_expenses_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_expenses_category` FOREIGN KEY (`category_id`) REFERENCES `expense_categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_expenses_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_expenses_paid_by` FOREIGN KEY (`paid_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_expenses_payment_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD CONSTRAINT `fk_expense_categories_parent` FOREIGN KEY (`parent_id`) REFERENCES `expense_categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `finance_reconciliations`
--
ALTER TABLE `finance_reconciliations`
  ADD CONSTRAINT `fk_finance_reconciliations_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_finance_reconciliations_shift` FOREIGN KEY (`shift_id`) REFERENCES `cashier_shifts` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_finance_reconciliations_user` FOREIGN KEY (`reconciled_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `finance_reconciliation_items`
--
ALTER TABLE `finance_reconciliation_items`
  ADD CONSTRAINT `fk_finance_reconciliation_items_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_finance_reconciliation_items_reconciliation` FOREIGN KEY (`reconciliation_id`) REFERENCES `finance_reconciliations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `financial_transactions`
--
ALTER TABLE `financial_transactions`
  ADD CONSTRAINT `fk_financial_transactions_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_financial_transactions_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_financial_transactions_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `goods_receipts`
--
ALTER TABLE `goods_receipts`
  ADD CONSTRAINT `fk_goods_receipts_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_goods_receipts_purchase_order_branch` FOREIGN KEY (`purchase_order_id`,`branch_id`) REFERENCES `purchase_orders` (`id`, `branch_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_goods_receipts_received_by` FOREIGN KEY (`received_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `goods_receipt_items`
--
ALTER TABLE `goods_receipt_items`
  ADD CONSTRAINT `fk_goods_receipt_items_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_goods_receipt_items_purchase_item` FOREIGN KEY (`purchase_item_id`) REFERENCES `purchase_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_goods_receipt_items_receipt` FOREIGN KEY (`goods_receipt_id`) REFERENCES `goods_receipts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `idempotency_keys`
--
ALTER TABLE `idempotency_keys`
  ADD CONSTRAINT `fk_idempotency_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `import_jobs`
--
ALTER TABLE `import_jobs`
  ADD CONSTRAINT `fk_import_jobs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `import_job_rows`
--
ALTER TABLE `import_job_rows`
  ADD CONSTRAINT `fk_import_job_rows_job` FOREIGN KEY (`job_id`) REFERENCES `import_jobs` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `inventory_batches`
--
ALTER TABLE `inventory_batches`
  ADD CONSTRAINT `fk_inventory_batches_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_batches_goods_receipt_item` FOREIGN KEY (`goods_receipt_item_id`) REFERENCES `goods_receipt_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_batches_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_batches_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `inventory_items`
--
ALTER TABLE `inventory_items`
  ADD CONSTRAINT `fk_inventory_items_batch` FOREIGN KEY (`batch_id`) REFERENCES `inventory_batches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_items_bin_warehouse` FOREIGN KEY (`bin_id`,`warehouse_id`) REFERENCES `bins` (`id`, `warehouse_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_items_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_inventory_items_warehouse_branch` FOREIGN KEY (`warehouse_id`,`branch_id`) REFERENCES `warehouses` (`id`, `branch_id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_audit_log`
--
ALTER TABLE `legacy_audit_log`
  ADD CONSTRAINT `legacy_audit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_batch_lots`
--
ALTER TABLE `legacy_batch_lots`
  ADD CONSTRAINT `legacy_batch_lots_ibfk_1` FOREIGN KEY (`medication_id`) REFERENCES `legacy_medications` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_batch_lots_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `legacy_suppliers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_batch_lots_ibfk_3` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_batch_lots_ibfk_4` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_customer_balances`
--
ALTER TABLE `legacy_customer_balances`
  ADD CONSTRAINT `legacy_customer_balances_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `legacy_patients` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_customer_balances_ibfk_2` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_dispenses`
--
ALTER TABLE `legacy_dispenses`
  ADD CONSTRAINT `legacy_dispenses_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `legacy_prescriptions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_dispenses_ibfk_2` FOREIGN KEY (`batch_lot_id`) REFERENCES `legacy_batch_lots` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_dispenses_ibfk_3` FOREIGN KEY (`dispensed_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_expenses`
--
ALTER TABLE `legacy_expenses`
  ADD CONSTRAINT `legacy_expenses_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `expense_categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_expenses_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_expenses_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_expenses_ibfk_4` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_inventory_movements`
--
ALTER TABLE `legacy_inventory_movements`
  ADD CONSTRAINT `legacy_inventory_movements_ibfk_1` FOREIGN KEY (`batch_lot_id`) REFERENCES `legacy_batch_lots` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_inventory_movements_ibfk_2` FOREIGN KEY (`performed_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_invoices`
--
ALTER TABLE `legacy_invoices`
  ADD CONSTRAINT `legacy_invoices_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `legacy_patients` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_invoices_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_invoices_ibfk_3` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_invoices_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_invoice_items`
--
ALTER TABLE `legacy_invoice_items`
  ADD CONSTRAINT `legacy_invoice_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `legacy_invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_invoice_items_ibfk_2` FOREIGN KEY (`medication_id`) REFERENCES `legacy_medications` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_invoice_items_ibfk_3` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_medications`
--
ALTER TABLE `legacy_medications`
  ADD CONSTRAINT `legacy_medications_ibfk_1` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_notifications`
--
ALTER TABLE `legacy_notifications`
  ADD CONSTRAINT `legacy_notifications_ibfk_1` FOREIGN KEY (`rule_id`) REFERENCES `notification_rules` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `legacy_patients`
--
ALTER TABLE `legacy_patients`
  ADD CONSTRAINT `legacy_patients_ibfk_1` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_payments`
--
ALTER TABLE `legacy_payments`
  ADD CONSTRAINT `legacy_payments_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `legacy_invoices` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_payments_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `legacy_patients` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_payments_ibfk_3` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_payments_ibfk_4` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_prescriptions`
--
ALTER TABLE `legacy_prescriptions`
  ADD CONSTRAINT `legacy_prescriptions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `legacy_patients` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_prescriptions_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_prescription_items`
--
ALTER TABLE `legacy_prescription_items`
  ADD CONSTRAINT `legacy_prescription_items_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `legacy_prescriptions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_prescription_items_ibfk_2` FOREIGN KEY (`medication_id`) REFERENCES `legacy_medications` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_refunds`
--
ALTER TABLE `legacy_refunds`
  ADD CONSTRAINT `legacy_refunds_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `legacy_payments` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_refunds_ibfk_2` FOREIGN KEY (`invoice_id`) REFERENCES `legacy_invoices` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_refunds_ibfk_3` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_refunds_ibfk_4` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_refunds_ibfk_5` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `legacy_suppliers`
--
ALTER TABLE `legacy_suppliers`
  ADD CONSTRAINT `legacy_suppliers_ibfk_1` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `legacy_supplier_balances`
--
ALTER TABLE `legacy_supplier_balances`
  ADD CONSTRAINT `legacy_supplier_balances_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `legacy_suppliers` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `legacy_supplier_balances_ibfk_2` FOREIGN KEY (`currency_code`) REFERENCES `currencies` (`code`) ON UPDATE CASCADE;

--
-- Constraints for table `medicines`
--
ALTER TABLE `medicines`
  ADD CONSTRAINT `fk_medicines_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicines_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicines_dosage_form` FOREIGN KEY (`dosage_form_id`) REFERENCES `dosage_forms` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicines_manufacturer` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicines_route` FOREIGN KEY (`route_id`) REFERENCES `routes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicines_strength` FOREIGN KEY (`strength_id`) REFERENCES `strengths` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicines_therapeutic_class` FOREIGN KEY (`therapeutic_class_id`) REFERENCES `therapeutic_classes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `medicine_ingredients`
--
ALTER TABLE `medicine_ingredients`
  ADD CONSTRAINT `fk_medicine_ingredients_ingredient` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_medicine_ingredients_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `fk_notifications_rule` FOREIGN KEY (`rule_id`) REFERENCES `notification_rules` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_notifications_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification_delivery_logs`
--
ALTER TABLE `notification_delivery_logs`
  ADD CONSTRAINT `fk_notification_delivery_notification` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification_preferences`
--
ALTER TABLE `notification_preferences`
  ADD CONSTRAINT `fk_notification_preferences_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `notification_rules`
--
ALTER TABLE `notification_rules`
  ADD CONSTRAINT `fk_notification_rules_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_notification_rules_template` FOREIGN KEY (`template_id`) REFERENCES `notification_templates` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `fk_patients_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_patients_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payments_payment_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payments_received_by` FOREIGN KEY (`received_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payments_sale_currency` FOREIGN KEY (`sale_id`,`currency_id`) REFERENCES `sales` (`id`, `currency_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_payments_shift` FOREIGN KEY (`shift_id`) REFERENCES `cashier_shifts` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `prescriptions`
--
ALTER TABLE `prescriptions`
  ADD CONSTRAINT `fk_prescriptions_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prescriptions_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prescriptions_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prescriptions_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prescriptions_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `prescription_items`
--
ALTER TABLE `prescription_items`
  ADD CONSTRAINT `fk_prescription_items_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_prescription_items_prescription` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_identifiers`
--
ALTER TABLE `product_identifiers`
  ADD CONSTRAINT `fk_product_identifiers_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchase_items`
--
ALTER TABLE `purchase_items`
  ADD CONSTRAINT `fk_purchase_items_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_items_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_items_tax_rate` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `purchase_item_closures`
--
ALTER TABLE `purchase_item_closures`
  ADD CONSTRAINT `fk_purchase_item_closures_item` FOREIGN KEY (`purchase_item_id`) REFERENCES `purchase_items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_item_closures_po` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_item_closures_user` FOREIGN KEY (`closed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `fk_purchase_orders_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_orders_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_orders_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_orders_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase_returns`
--
ALTER TABLE `purchase_returns`
  ADD CONSTRAINT `fk_purchase_returns_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_returns_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_returns_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_returns_po` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_returns_refund_method` FOREIGN KEY (`refund_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_returns_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase_return_items`
--
ALTER TABLE `purchase_return_items`
  ADD CONSTRAINT `fk_purchase_return_items_batch` FOREIGN KEY (`batch_id`) REFERENCES `inventory_batches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_return_items_inventory` FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_return_items_purchase_item` FOREIGN KEY (`purchase_item_id`) REFERENCES `purchase_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_return_items_receipt_item` FOREIGN KEY (`goods_receipt_item_id`) REFERENCES `goods_receipt_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_purchase_return_items_return` FOREIGN KEY (`purchase_return_id`) REFERENCES `purchase_returns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `return_items`
--
ALTER TABLE `return_items`
  ADD CONSTRAINT `fk_return_items_batch` FOREIGN KEY (`batch_id`) REFERENCES `inventory_batches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_return_items_sale_item` FOREIGN KEY (`sale_item_id`) REFERENCES `sale_items` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_return_items_sale_return` FOREIGN KEY (`sale_return_id`) REFERENCES `sale_returns` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_return_items_tax_rate` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `fk_sales_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sales_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sales_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sales_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sales_shift` FOREIGN KEY (`shift_id`) REFERENCES `cashier_shifts` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `fk_sale_items_batch_medicine` FOREIGN KEY (`batch_id`,`medicine_id`) REFERENCES `inventory_batches` (`id`, `medicine_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sale_items_medicine` FOREIGN KEY (`medicine_id`) REFERENCES `medicines` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sale_items_sale` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sale_items_tax_rate` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `sale_returns`
--
ALTER TABLE `sale_returns`
  ADD CONSTRAINT `fk_sale_returns_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sale_returns_sale` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sale_returns_shift` FOREIGN KEY (`shift_id`) REFERENCES `cashier_shifts` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `settings`
--
ALTER TABLE `settings`
  ADD CONSTRAINT `fk_settings_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `stock_adjustments`
--
ALTER TABLE `stock_adjustments`
  ADD CONSTRAINT `fk_stock_adjustments_batch` FOREIGN KEY (`batch_id`) REFERENCES `inventory_batches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_adjustments_bin` FOREIGN KEY (`bin_id`) REFERENCES `bins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_adjustments_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_adjustments_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_adjustments_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `fk_stock_movements_batch` FOREIGN KEY (`batch_id`) REFERENCES `inventory_batches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_from_bin` FOREIGN KEY (`from_bin_id`) REFERENCES `bins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_to_bin` FOREIGN KEY (`to_bin_id`) REFERENCES `bins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_movements_warehouse_branch` FOREIGN KEY (`warehouse_id`,`branch_id`) REFERENCES `warehouses` (`id`, `branch_id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_transfers`
--
ALTER TABLE `stock_transfers`
  ADD CONSTRAINT `fk_stock_transfers_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_transfers_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_transfers_from_warehouse_branch` FOREIGN KEY (`from_warehouse_id`,`branch_id`) REFERENCES `warehouses` (`id`, `branch_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_transfers_to_warehouse_branch` FOREIGN KEY (`to_warehouse_id`,`branch_id`) REFERENCES `warehouses` (`id`, `branch_id`) ON UPDATE CASCADE;

--
-- Constraints for table `stock_transfer_items`
--
ALTER TABLE `stock_transfer_items`
  ADD CONSTRAINT `fk_stock_transfer_items_batch` FOREIGN KEY (`batch_id`) REFERENCES `inventory_batches` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_transfer_items_from_bin` FOREIGN KEY (`from_bin_id`) REFERENCES `bins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_transfer_items_to_bin` FOREIGN KEY (`to_bin_id`) REFERENCES `bins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_stock_transfer_items_transfer` FOREIGN KEY (`stock_transfer_id`) REFERENCES `stock_transfers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `supplier_balances`
--
ALTER TABLE `supplier_balances`
  ADD CONSTRAINT `fk_supplier_balances_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_supplier_balances_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `supplier_payments`
--
ALTER TABLE `supplier_payments`
  ADD CONSTRAINT `fk_supplier_payments_currency` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_supplier_payments_paid_by` FOREIGN KEY (`paid_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_supplier_payments_payment_method` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_supplier_payments_purchase_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_supplier_payments_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `fk_user_roles_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_roles_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD CONSTRAINT `fk_user_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD CONSTRAINT `fk_warehouses_branch` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;